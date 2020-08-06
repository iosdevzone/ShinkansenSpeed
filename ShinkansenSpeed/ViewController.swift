//
//  ViewController.swift
//  ShinkansenSpeed
//
//  Created by idz on 6/30/15.
//  Copyright (c) 2015-2016 iOS Developer Zone. 
//  License: MIT https://raw.githubusercontent.com/iosdevzone/ShinkansenSpeed/master/LICENSE
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var speedLabel: UILabel!
    
    // Configure an integer only number formatter
    static let numberFormatter: NumberFormatter =  {
        let mf = NumberFormatter()
        mf.minimumFractionDigits = 0
        mf.maximumFractionDigits = 0
        return mf
    }()
    
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Please sir, may I know where I am?
        if(CLLocationManager.authorizationStatus() != CLAuthorizationStatus.authorizedWhenInUse)
        {
            self.locationManager.requestWhenInUseAuthorization()
            
        }
        // Configure location manager
        locationManager.activityType = CLActivityType.otherNavigation
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        // Configure map view
        mapView.showsUserLocation = true
        mapView.setUserTrackingMode(MKUserTrackingMode.follow, animated: true)
        // Stop the display going asleep
        UIApplication.shared.isIdleTimerDisabled = true;
    }
    /**
     Called when location changes, updates speed in speed label.
     */
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {    
        guard let newLocation = locations.first else { return }
        
        if(newLocation.speed > 0) {
            let kmh = newLocation.speed / 1000.0 * 60.0 * 60.0
            if let speed = ViewController.numberFormatter.string(from: NSNumber(value: kmh as Double)) {
                self.speedLabel.text = "\(speed) km/h"
            }
        }
        else {
            self.speedLabel.text = "---"
        }
    }



}

