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


class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {


    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var pickerView: UIPickerView!

    var cops = [Cops]()
    var criteria: Criteria?
    var crimes = ["Threats", "Auto Theft", "Fight", "Suspicious Circumstances", "Hit & Run", "Theft", "Property", "Fraud", "ACC", "Disturbance", "Burgulary", "Traffic", "Shoplift", "Robbery", "Narcotics", "ASLT"]
    let regionRadius: CLLocationDistance = 1000


    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self

        // MARK: center location
        let initialLocation = CLLocation(latitude: 47.6062, longitude: -122.3321)
        centerMapOnLocation(location: initialLocation)

        getCrimeData()
    }
// MARK: pickerview
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return crimes.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let crit = Criteria()
        crit.crime = crimes[row]
        crit.location = "here"
        criteria = crit
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return crimes[row]
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
// MARK: get data
    func getCrimeData() {
      Alamofire.request("https://data.seattle.gov/resource/pu5n-trf4.json").responseJSON { response in
        if let JSON = response.result.value {
            self.extractData(JSON)
          }
      }
    }
// MARK: parse data
    func extractData(_ data: Any) {
      if let value = data as? NSArray {
        for i in 0 ..< value.count {
         if let crimeReport = value[i] as? NSDictionary
         {
            if let cop = Cops.parseInfo(crimeReport) {
                cops.append(cop)
            }
          }
        }
      }
      print("criteria: \(criteria?.crime)")
    }

    @IBAction func MapButton(_ sender: UIButton) {
        getCrimeData()
        mapView.addAnnotations(cops)
        mapView.delegate = self
    }

    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}
