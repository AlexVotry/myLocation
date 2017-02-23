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
 var cops = [Cops]()
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var myLocation: UILabel!

    let regionRadius: CLLocationDistance = 1000


    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: center location
        let initialLocation = CLLocation(latitude: 47.6062, longitude: -122.3321)
        centerMapOnLocation(location: initialLocation)

        getCrimeData("ACC")
        
    }
   
    // MARK: get data
    func getCrimeData(_ criteria: String) {
      Alamofire.request("https://data.seattle.gov/resource/pu5n-trf4.json").responseJSON { response in
        if let JSON = response.result.value {
            self.extractData(JSON, criteria)
          }
      }
    }

    func extractData(_ data: Any, _ criteria: String?) {

      var crimeData:Array < Any > = Array < Any >()
      if let value = data as? NSArray {
        for i in 0 ..< value.count {
         if let crimeReport = value[i] as? NSDictionary
         {
            if let cop = Cops.parseInfo(crimeReport) {
                cops.append(cop)
            }
          }
        }
        mapView.addAnnotations(cops)
        mapView.delegate = self
      }
    }
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}
