//
//  WorldVC.swift
//  ARWorld
//
//  Created by Alex Curylo on 10/14/17.
//  Copyright © 2017 Trollwerks Inc. All rights reserved.
//

import ARCL
import ARKit
import CoreLocation
import MapKit
import SceneKit

final class WorldVC: UIViewController, CLLocationManagerDelegate {

    private var scene = SceneLocationView()
    
    lazy private var locator: CLLocationManager = { lm in
        lm.delegate = self
        lm.desiredAccuracy = kCLLocationAccuracyBest
        lm.requestAlwaysAuthorization()
        return lm
    }(CLLocationManager())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scene.run()
        view.addSubview(scene)

        locator.startUpdatingLocation()
        locate()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scene.frame = view.bounds
    }
    
    private func locate() {
        guard let here = locator.location else {
            return
        }

        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = title
        request.region = MKCoordinateRegionMakeWithDistance(here.coordinate, 5000, 5000)
        let search = MKLocalSearch(request: request)

        search.start { response, error in
            guard let response = response,
                  error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                response.mapItems.forEach {
                    self.located(place: $0)
                }
           }
        }
    }
    
    func located(place: MKMapItem) {
        guard let location = place.placemark.location,
              let title = place.placemark.name else {
            return
        }
        let node = PlaceNode(location: location, title: title)
        scene.addLocationNodeWithConfirmedLocation(locationNode: node)
    }
}

