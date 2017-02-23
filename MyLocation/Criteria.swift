//
//  Criteria.swift
//  MyLocation
//
//  Created by Alex Votry on 2/23/17.
//  Copyright © 2017 Alex Votry. All rights reserved.
//

import Foundation

class Criteria: NSObject, NSCoding {

    var crime: String?
    var location: String?
    var time: String?

    override init() {
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        self.crime = aDecoder.decodeObject(forKey: "crime") as! String?
        self.location = aDecoder.decodeObject(forKey: "location") as! String?
        self.time = aDecoder.decodeObject(forKey: "time") as! String?
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.crime, forKey: "crime")
        aCoder.encode(self.location, forKey: "location")
        aCoder.encode(self.time, forKey: "time")
    }
}
