//
//  MyNewsVC.swift
//  OnrampProject
//
//  Created by Bart on 3/3/20.
//

import UIKit
import CoreLocation

class MyNewsVC: UITableViewController {
    
    let locationManager = CLLocationManager()
    var latitude: String = "0.000000"
    var longitude: String = "0.000000"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("MyNewsVC: viewDidLoad()")
        
        self.title = "My News"
        
        locationManager.delegate = self
        checkLocationAuthorization()
    }
    
    func checkLocationAuthorization() {
        
        print("checkLocationAuthorization()")
        
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            print(".authorizedWhenInUse")
            
            if latitude == "0.000000" || longitude == "0.000000" {
                print("startUpdatingLocation()")
                locationManager.startUpdatingLocation()
            } else {
                print("stopUpdatingLocation")
                locationManager.stopUpdatingLocation()
            }
        case .denied:
            print(".denied")
            locationManager.requestWhenInUseAuthorization()
        case .notDetermined:
            print(".notDetermined")
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("restricted")
        default:
            print("default")
        }
    }
}

extension MyNewsVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print("locationManager(): didUpdateLocations")
        
        latitude = String(format: "%f", locationManager.location?.coordinate.latitude ?? "0.000000")
        longitude = String(format: "%f", locationManager.location?.coordinate.longitude ?? "0.000000")
        
        print("lat: \(latitude)")
        print("lon: \(longitude)")
        
        checkLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        print("locationManager(): didChangeAuthorization")
        
        checkLocationAuthorization()
    }
}
