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
    var results: [LocationVM] = []
    var articles: [ArticleVM] = []
    var usersCity: String?
    
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
                getUsersCityAPI(lat: latitude, lon: longitude)
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
    
    func getLocalNewsAPI(usersCity: String) {
        
        print("getLocalNewsAPI(usersCity: String)")
        
        let headers = [
            "Content-Type": "application/json"
        ]
        
        var request = URLRequest(url: URL(string: "http://newsapi.org/v2/everything?q=\(usersCity)&pageSize=30&apiKey=57fd062826eb4196b020535fe631778d")!)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        
        session.dataTask(with: request) { (data, response, error) in
            
            if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                print(response)
                print("statusCode: \(response.statusCode)")
            } else {
                print("getLocalNewsAPI(usersCity: String)")
                return
            }
            
            if let data = data {
                let decoder = JSONDecoder()
                
                do {
                    decoder.dateDecodingStrategy = .iso8601
                    let json = try decoder.decode(ArticleVM.self, from: data)
                    self.articles = json.articles?.map({return ArticleVM(article: $0)}) ?? []
                    print("total articles: \(self.articles.count)")
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
    
    func getUsersCityAPI(lat: String, lon: String) {
        
        print("getUsersCityAPI(lat: String, lon: String)")
        
        let headers = [
            "Content-Type": "application/json"
        ]
        
        var request = URLRequest(url: URL(string: "https://api.opencagedata.com/geocode/v1/json?q=\(lat)+\(lon)&key=3e2e5ffd217e4c3185e7aa66775ff778")!)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        
        session.dataTask(with: request) { (data, response, error) in
            
            if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                print(response)
                print("statusCode: \(response.statusCode)")
            } else {
                print("localNewsAPI() - FAILD")
                return
            }
            
            if let data = data {
                let decoder = JSONDecoder()
                
                do {
                    let json = try decoder.decode(LocationVM.self, from: data)
                    self.results = json.results?.map({return LocationVM(result: $0)}) ?? []
                    
                    if let city = self.results[0].city {
                        self.usersCity = city
                        print(city)
                        self.getLocalNewsAPI(usersCity: city)
                    }
                } catch {
                    print(error)
                }
            }
        }.resume()
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
