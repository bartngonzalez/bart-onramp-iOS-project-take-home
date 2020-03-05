//
//  Networking.swift
//  OnrampProject
//
//  Created by Bart on 3/4/20.
//

import Foundation

class Networking {
    
    private let googleNewsAPIKey = "57fd062826eb4196b020535fe631778d"
    private let openCageDataAPIKey = "3e2e5ffd217e4c3185e7aa66775ff778"
    
    // MARK: Google News API for MyNewsVC, HeadlinsVC and SearchVC articles.
    func googleNewsAPI(url: String, completion: @escaping (Result<ArticleVM, Error>) -> ()) {
        
        let urlNoSpace = url.replacingOccurrences(of: " ", with: "")
        
        let headers = [
            "Content-Type": "application/json"
        ]
        
        var request = URLRequest(url: URL(string: urlNoSpace + googleNewsAPIKey)!)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        
        session.dataTask(with: request) { (data, response, error) in
            
            if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                print(response)
            } else {
                print("googleNewsAPI: response faild")
                return
            }
            
            if let data = data {
                let decoder = JSONDecoder()
                
                do {
                    decoder.dateDecodingStrategy = .iso8601
                    let json = try decoder.decode(ArticleVM.self, from: data)
                    completion(.success(json))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    // MARK: Open Cage Data API gets the users location in a human readable format from coordinates.
    func openCageDataAPI(url: String, completion: @escaping (Result<LocationVM, Error>) -> ()) {
        
        let headers = [
            "Content-Type": "application/json"
        ]
        
        var request = URLRequest(url: URL(string: url + openCageDataAPIKey)!)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        
        session.dataTask(with: request) { (data, response, error) in
            
            if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                print(response)
                print("statusCode: \(response.statusCode)")
            } else {
                print("openCageDataAPI: response faild")
                return
            }
            
            if let data = data {
                let decoder = JSONDecoder()
                
                do {
                    let json = try decoder.decode(LocationVM.self, from: data)
                    completion(.success(json))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
