//
//  ColorPins.swift
//  MyLocation
//
//  Created by Alex Votry on 2/25/17.
//  Copyright © 2017 Alex Votry. All rights reserved.
//

import Foundation
import MapKit

class ColorPins: MKPointAnnotation {
    var pinColor: UIColor
    
    init(pinColor: UIColor) {
        self.pinColor = pinColor
        super.init()
    }
}
