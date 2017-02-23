//
//  ViewController.swift
//  MyLocation
//
//  Created by Alex Votry on 2/21/17.
//  Copyright © 2017 Alex Votry. All rights reserved.
//

import UIKit
import MapKit
import Alamofire


class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var myLocation: UILabel!

    let regionRadius: CLLocationDistance = 1000


    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: center location
        let initialLocation = CLLocation(latitude: 47.6062, longitude: -122.3321)
        centerMapOnLocation(location: initialLocation)

        loadInitialData()
        mapView.addAnnotations(cops)
        mapView.delegate = self

        // single crime location:
//        let cops = Cops(title: "SUSPICIOUS PERSON", district: "S", beat: "S3", coordinate: CLLocationCoordinate2D(latitude: 47.513439037, longitude: -122.252409716))
//
//        mapView.addAnnotation(cops)
    }
    var cops = [Cops]()
    func loadInitialData() {
      let fileName = Bundle.main.path(forResource: "PublicArt", ofType: "json");
      var data: Data?
      do {
          data = try Data(contentsOf: URL(fileURLWithPath: fileName!), options: NSData.ReadingOptions(rawValue: 0))
      } catch _ {
          data = nil
      }

      var jsonObject: Any? = nil
      if let data = data {
          do {
            jsonObject = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions(rawValue: 0))
          } catch _{
            jsonObject = nil
          }
      }

      if let jsonObject = jsonObject as? [String: Any],
          let jsonData = JSONValue.fromObject(jsonObject)?["data"]?.array {
            for copJSON in jsonData {
              if let copJSON = copJSON.array,
              let cop = Cops.fromJSON(copJSON) {
                cops.append(cop)
              }
            }
      }
    }
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}
