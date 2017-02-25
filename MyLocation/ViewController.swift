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
    @IBOutlet weak var locationPickerView: UIPickerView!

    var cops = [Cops]()
    var group = Crime()
    var criteria: Criteria?
    var crimes = ["Threats", "Gun Fire", "Assault", "Auto Theft", "All", "Fight", "Suspicious Person", "Theft", "Property Damage", "Fraud", "Traffic Accident", "Disturbance", "Burgulary", "Robbery", "Narcotics"]
    var locations = ["Ballard", "Northgate", "Greenlake", "University District", "Queen Anne", "Capitol Hill", "Downtown", "Beacon Hill", "West Seattle", "White Center"]

    let regionRadius: CLLocationDistance = 5000
    var currentLocation = CLLocation(latitude: 47.6062, longitude: -122.3321)

    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        locationPickerView.delegate = self
        locationPickerView.dataSource = self


// MARK: center location
        centerMapOnLocation(location: currentLocation)
        getCrimeData()
    }

// MARK: pickerview (crimes)
    func pickerView(_ picker: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if picker.tag == 1 {
          return crimes.count
        }
        else {
          return locations.count
        }
    }

    func pickerView(_ picker: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
      let crit = Criteria()
      if picker.tag == 1 {
        self.mapView.removeAnnotations(self.mapView.annotations)
        crit.crime = crit.matchIt(crimes[row])
      }
      else {
        currentLocation = (crit.locate(locations[row]) as? CLLocation)!
      }
      criteria = crit
      centerMapOnLocation(location: currentLocation)
//      getCrimeData()
//      self.mapView.addAnnotations(cops)
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
      if pickerView.tag == 1 {
        return crimes[row]
      }
      else {
        return locations[row]
      }
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
      if let crimeReport = data as? NSArray
      {
        if let crime = criteria?.crime
        {
          if crime == "ALL" {
            print("hit it")
            cops = group.reportAll(crimeReport)
          } else {
            print(crime)
            cops = group.report(crimeReport, criteria: crime)
            print(cops.count)
          }
        }
      }
    }
    // MARK: map button
    @IBAction func MapButton(_ sender: UIButton) {
        getCrimeData()
        mapView.removeAnnotations(mapView.annotations)
        URLCache.shared.removeAllCachedResponses()
        mapView.addAnnotations(cops)

        mapView.delegate = self
    }

    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}
