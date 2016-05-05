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
    static let numberFormatter: NSNumberFormatter =  {
        let mf = NSNumberFormatter()
        mf.minimumFractionDigits = 0
        mf.maximumFractionDigits = 0
        return mf
    }()
    
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Please sir, may I know where I am?
        if(CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedWhenInUse)
        {
            self.locationManager.requestWhenInUseAuthorization()
            
        }
        // Configure location manager
        locationManager.activityType = CLActivityType.OtherNavigation
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        // Configure map view
        mapView.showsUserLocation = true
        mapView.setUserTrackingMode(MKUserTrackingMode.Follow, animated: true)
        // Stop the display going asleep
        UIApplication.sharedApplication().idleTimerDisabled = true;
        
    }
    /**
     Called when location changes, updates speed in speed label.
     */
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        
        if(newLocation.speed > 0) {
            let kmh = newLocation.speed / 1000.0 * 60.0 * 60.0
            if let speed = ViewController.numberFormatter.stringFromNumber(NSNumber(double: kmh)) {
                self.speedLabel.text = "\(speed) km/h"
            }
        }
        else {
            self.speedLabel.text = "---"
        }
    }



}

