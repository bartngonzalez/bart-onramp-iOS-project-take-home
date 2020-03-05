//
//  MyNewsVC.swift
//  OnrampProject
//
//  Created by Bart on 3/3/20.
//

import UIKit
import CoreLocation
import SafariServices

class MyNewsVC: UITableViewController {
    
    @IBOutlet var myNewsTableView: UITableView!
    
    let locationManager = CLLocationManager()
    var latitude: String = "0.000000"
    var longitude: String = "0.000000"
    var results: [LocationVM] = []
    var articles: [ArticleVM] = []
    var usersCity: String?
    let networking = Networking()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("MyNewsVC: viewDidLoad()")
        
        self.title = "My News"
        
        // UITableView's
        myNewsTableView.delegate = self
        myNewsTableView.dataSource = self
        
        // CoreLocation
        locationManager.delegate = self
        checkLocationAuthorization()
        
        // XIB
        let articleTableViewCellXIB = UINib(nibName: "ArticleTableViewCell", bundle: nil)
        myNewsTableView.register(articleTableViewCellXIB, forCellReuseIdentifier: "articleCellXIB")
    }
    
    // MARK: Determine authorization status. Show articles if .authorizedWhenInUse or remove if .denied
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
                let url = "https://api.opencagedata.com/geocode/v1/json?q=\(latitude)+\(longitude)&key="
                openCageDataAPI(url: url)
            }
        case .denied:
            print(".denied")
            self.articles = []
            myNewsTableView.reloadData()
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
    
    // MARK: Google News API from Networking.swift. Gets articles based on users city (location).
    func googleNewsAPI(usersCity: String) {
        
        networking.googleNewsAPI(url: "http://newsapi.org/v2/everything?q=\(usersCity)&pageSize=30&apiKey=") { (result) in
            
            switch result {
            case .success(let json):
                self.articles = json.articles?.map({return ArticleVM(article: $0)}) ?? []
                DispatchQueue.main.async {
                    self.myNewsTableView.reloadData()
                }
            case .failure(let error):
                print("Faild to get articles:", error)
            }
        }
    }
    
    // MARK: Open Cage Data API gets users city (location) from latitude and longitude. Calls Google News API to fetch articles.
    func openCageDataAPI(url: String) {
        
        networking.openCageDataAPI(url: url) { (result) in
            switch result {
            case .success(let json):
                self.results = json.results?.map({return LocationVM(result: $0)}) ?? []
                if let city = self.results[0].city {
                    self.usersCity = city
                    self.googleNewsAPI(usersCity: self.usersCity!)
                }
            case .failure(let error):
                print("Faild to get users location:", error)
            }
        }
    }
    
    @IBAction func presentSearchVC(_ sender: Any) {
        
        print("presentSearchVC")
        
        let storyboard = UIStoryboard(name: "Search", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SearchSB") as! SearchVC
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: UITableView Protocol config
extension MyNewsVC: SFSafariViewControllerDelegate {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        self.articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let article = articles[indexPath.row]
        let cell = myNewsTableView.dequeueReusableCell(withIdentifier: "articleCellXIB") as! ArticleTableViewCellVC
        
        cell.setArticles(article: article)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        myNewsTableView.deselectRow(at: indexPath, animated: true)
        
        if let url = URL(string: articles[indexPath.row].url!) {
            let vc = SFSafariViewController(url: url)
            vc.delegate = self
            present(vc, animated: true)
        }
    }
}

// MARK: CLLocationManager Protocol config
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
