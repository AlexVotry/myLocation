//
//  MCMapView.swift
//  MyLocation
//
//  Created by Alex Votry on 2/21/17.
//  Copyright © 2017 Alex Votry. All rights reserved.
//

import MapKit

extension ViewController: MKMapViewDelegate {
   func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
       if let annotation = annotation as? Cops {
         let identifier = "copsPin"
         var view: MKPinAnnotationView
        if let pinView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
            pinView.annotation = annotation
            view = pinView
        } else {
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
            }

        view.pinTintColor = annotation.pinTintColor()
            return view
            }
            return nil
        }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! Cops
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }
}
