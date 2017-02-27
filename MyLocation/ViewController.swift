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
    var group = Crime()
    var criteria: Criteria?
    var pickerData: [[String]] = [[String]]()
    var crimes = ["Auto Theft", "Suspicious", "Robbery", "Drugs", "Burgulary", "All",  "Theft","Harrassment",  "Fraud", "Property", "Traffic", "Assault"]
    var locations = ["Ballard", "Northgate", "Greenlake", "University", "Queen Anne", "Downtown",  "Capitol Hill","Beacon Hill", "West Seattle", "White Center"]
    let crimeComponent = 1
    let locationComponent = 0
    let regionRadius: CLLocationDistance = 800
    var currentLocation = CLLocation(latitude: 47.6062, longitude: -122.3321)

    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self

        pickerData = [locations, crimes]
        pickerView.selectRow(5, inComponent: crimeComponent, animated: true)
        pickerView.selectRow(5, inComponent: locationComponent, animated: true)


        // MARK: center location
        centerMapOnLocation(location: currentLocation)
    }

    // MARK: pickerview (crimes)
    func pickerView(_ picker: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData[component].count
    }
    func pickerView(_ picker: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        getCriteria()
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[component][row]
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
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
        
        URLCache.shared.removeAllCachedResponses()

        if let crimeReport = data as? NSArray
        {
            if let crime = criteria?.crime
            {
                if crime[0] as! String == "ALL" {
                    cops = group.reportAll(crimeReport)
                    print("total: \(cops.count)")
                } else {
                    cops = group.report(crimeReport, criteria: crime)
                    print("\(crime[0]): \(cops.count)")
                }
            }
        }
    }

    // MARK: show crimes button
    @IBAction func MapButton(_ sender: UIButton) {
        self.mapView.removeAnnotations(self.mapView.annotations)
        getCrimeData()
        mapView.addAnnotations(cops)
        mapView.delegate = self
    }


    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    // MARK: get criteria
    func getCriteria() {
        let crit = Criteria()
        let crime = pickerData[crimeComponent][pickerView.selectedRow(inComponent: crimeComponent)]
        let location = pickerData[locationComponent][pickerView.selectedRow(inComponent: locationComponent)]

        getCrimeData()
        crit.crime = crit.matchIt(crime)
        currentLocation = (crit.locate(location) as? CLLocation)!
        criteria = crit
        centerMapOnLocation(location: currentLocation)
    }
}
