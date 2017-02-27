//
//  Criteria.swift
//  MyLocation
//
//  Created by Alex Votry on 2/23/17.
//  Copyright © 2017 Alex Votry. All rights reserved.
//

import Foundation
import MapKit

class Criteria {

    var crime: NSArray?
    var location: String?
    var time: String?

    func matchIt(_ criteria: String) -> NSArray {
      var crime: NSArray

      switch criteria {
      case "Auto Theft":
        crime = ["AUTO THEFT", "CAR PROWL", "BICYCLE THEFT"]
      case "Suspicious":
        crime = ["SUSPICIOUS", "MENTAL", "MISCHIEF", "NUISANCE", "LEWD", "NOISE"]
      case "Robbery":
        crime = ["ROBBERY"]
      case "Theft":
        crime = ["THEFT"]
      case "Drugs":
        crime = ["NARC", "LIQUOR", "VICE", "DRUG"]
      case "Burgulary":
        crime = ["ALARM", "BURGLARY", "TRESPASS", "BURGLARY - COMMERCIAL", "BURG"]
      case "Harrassment":
        crime = ["HARASSMENT", "HARAS", "THREATS", "DISTURBANCE"]
      case "Fraud":
        crime = ["FRAUD", "FORGERY, BAD CHECKS"]
      case "Traffic":
        crime = ["ACCIDENT", "ACC"]
      case "Assault":
        crime = ["ASLT", "FIGHT", "SHOTS", "GUN", "DOWN"]
      case "Property":
        crime = ["PROPERTY - DAMAGE"]
      default:
        crime = [criteria.uppercased()]
      }
      return crime
    }
    func locate(_ area: String) -> CLLocation {
      var latitude: Double
      var longitude: Double

      switch area {
      case "Ballard":
        latitude = 47.679494
        longitude = -122.382889
      case "Northgate":
        latitude = 47.707501
        longitude = -122.325855
      case "Greenlake":
        latitude = 47.679151
        longitude = -122.323623
      case "University District":
        latitude = 47.661189
        longitude = -122.314036
      case "Queen Anne":
        latitude = 47.6361
        longitude = -122.3593
      case "Capitol Hill":
        latitude = 47.6296
        longitude = -122.3134
      case "Downtown":
        latitude = 47.6062
        longitude = -122.3321
      case "Beacon Hill":
        latitude = 47.55611
        longitude = -122.29702
      case "West Seattle":
        latitude = 47.5667
        longitude = -122.3868
      case "White Center":
        latitude = 47.5089
        longitude = -122.3551
      default:
        latitude = 47.6062
        longitude = -122.3321
      }
      let coordinate = CLLocation(latitude: latitude, longitude: longitude)
   return coordinate
    }
}
