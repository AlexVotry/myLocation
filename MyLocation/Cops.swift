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
    let crime: String

    init(title: String, district: String, beat: String, coordinate: CLLocationCoordinate2D, crime: String ) {
        self.title = title
        self.district = district
        self.beat = beat
        self.coordinate = coordinate
        self.crime = crime

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
       let crime = title
    return Cops(title: title, district: district, beat: beat, coordinate: coordinate, crime: crime)
   }

    var subtitle: String? {
        return district
    }

    func pinTintColor() -> UIColor {

      var color: UIColor

        switch crime {
        case "AUTO THEFT",
             "THEFT - CAR PROWL",
             "BICYCLE THEFT",
             "ARMED ROBBERY",
             "STRONG ARM ROBBERY",
             "ALARMS - RESIDENTIAL BURGLARY",
             "BURGLARY - RESIDENTIAL, UNOCCUPIED",
             "TRESPASS",
             "BURGLARY - COMMERCIAL",
             "BURGLARY - UNOCCUPIED STRUCTURE ON RESIDENTIAL PROPERTY",
             "SUSPICIOUS CIRCUMSTANCES - BUILDING (OPEN DOOR, ETC.)",
             "FRAUD (INCLUDING IDENTITY THEFT)",
             "FORGERY, BAD CHECKS":
          color = MKPinAnnotationView.purplePinColor()
            
        case "SUSPICIOUS PERSON",
             "SUSPICIOUS VEHICLE",
             "MENTAL COMPLAINT",
             "MISCHIEF, NUISANCE COMPLAINTS",
             "LEWD CONDUCT",
             "NOISE DISTURBANCE",
             "PORNOGRAPHY",
             "HARASSMENT, THREATS",
             "ASSAULTS, OTHER",
             "PERSON WITH A WEAPON (NOT GUN)",
             "PERSON WITH A GUN":
          color = MKPinAnnotationView.redPinColor()

        case "NARCOTICS, OTHER",
             "LIQUOR VIOLATION - INTOXICATED PERSON",
             "LIQUOR VIOLATION - ADULT",
             "NARCOTICS ACTIVITY REPORT",
             "VICE, OTHER", "CASUALTY - DRUG RELATED (OVERDOSE, OTHER)",
             "PROPERTY - DAMAGE",
             "ACCIDENT INVESTIGATION",
             "GANG GRAFFITI":
          color = MKPinAnnotationView.greenPinColor()

        default:
          color = MKPinAnnotationView.greenPinColor()
        }
      return color
    }

    func mapItem() -> MKMapItem {
        let addressDict = [CNPostalAddressStreetKey: subtitle!]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)

        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title

        return mapItem
    }

}
