//
//  MapViewExtension.swift
//  geoMessenger
//
//  Created by Ivor D. Addo, PhD on 10/17/17.
//  Copyright © 2017 water. All rights reserved.
//

import UIKit
import MapKit

extension FirstViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
    {
        if let annotation = annotation as? Message {
            let identifier = "Pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -8, y: -5)
                view.pinTintColor = .green
                view.animatesDrop = true
                // view.image = UIImage(named: "mapButtonOff.png")
                view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIButton
            }
            return view
        }
        return nil
    }
    
    func mapView(_ mapView: MKMapView, annotationView view :MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        let message = view.annotation as! Message
        let placeName = message.title
        let placeInfo = message.subtitle
        
        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        // add a button to remove the annotation
        ac.addAction(UIAlertAction(title: "Remove", style: .default) {
            (result: UIAlertAction) -> Void in
            mapView.removeAnnotation(message)
        })
        
        present(ac, animated: true)
    }
}


