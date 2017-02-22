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

    class func fromJSON(_ json: [JSONValue]) -> Cops? {

        var title: String
        if let titleOrNil = json[16].string {
            title = titleOrNil
        }  else {
            title = ""
            }
            let district = json[12].string
            let beat = json[15].string
            let latitude = (json[18].string! as NSString).doubleValue
            let longitude = (json[19].string! as NSString).doubleValue
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)

            return Cops(title: title, district: district!, beat: beat!, coordinate: coordinate)
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
