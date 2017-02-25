//
//  crime.swift
//  MyLocation
//
//  Created by Alex Votry on 2/23/17.
//  Copyright © 2017 Alex Votry. All rights reserved.
//

import Foundation

class Crime {
  var cops = [Cops]()

  func report(_ value: NSArray, criteria: NSArray) -> [Cops]{
    cops = []
    for i in 0 ..< value.count
    {
      if let crimeReport = value[i] as? NSDictionary
      {
        if let description = crimeReport["initial_type_description"] as? String
        {
          for j in 0 ..< criteria.count {
            let group = criteria[j] as! String
            if description.range(of: group, options: .regularExpression) != nil
            {
              if let cop = Cops.parseInfo(crimeReport)
              {
                cops.append(cop)
              }
            }
          }
        }
      }
    }
    return cops
  }

  func reportAll(_ value: NSArray) -> [Cops] {
    for i in 0 ..< value.count
    {
      if let crimeReport = value[i] as? NSDictionary
      {
        if let cop = Cops.parseInfo(crimeReport)
        {
          cops.append(cop)
        }
      }
    }
    return cops
  }
}
