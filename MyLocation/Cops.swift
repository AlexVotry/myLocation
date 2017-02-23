//
//  Cops.swift
//  MyLocation
//
//  Created by Alex Votry on 2/21/17.
//  Copyright © 2017 Alex Votry. All rights reserved.
//
import Foundation
import MapKit
import Contacts

class Cops: NSObject, MKAnnotation {
    let title: String?
    let district: String
    let beat: String
    let coordinate: CLLocationCoordinate2D

    init(title: String, district: String, beat: String, coordinate: CLLocationCoordinate2D ) {
        self.title = title
        self.district = district
        self.beat = beat
        self.coordinate = coordinate

        super.init()
    }

    class func parseInfo(_ crimeReport: NSDictionary ) -> Cops? {

        var title: String
        if let tempTitle = crimeReport["event_clearance_description"] {
            title = tempTitle as! String
        } else {
            title = crimeReport["initial_type_description"] as! String
        }
       let district = crimeReport["hundred_block_location"] as! String
       let beat = crimeReport["zone_beat"] as! String
       let latitudeString = crimeReport["latitude"] as! String
       let latitude = Double(latitudeString)
       let longitudeString = crimeReport["longitude"] as! String
       let longitude = Double(longitudeString)
       let coordinate = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
    return Cops(title: title, district: district, beat: beat, coordinate: coordinate)
   }

    var subtitle: String? {
        return district
    }

    func mapItem() -> MKMapItem {
        let addressDict = [CNPostalAddressStreetKey: subtitle!]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)

        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title

        return mapItem
    }

}
