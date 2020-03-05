//
//  Networking.swift
//  OnrampProject
//
//  Created by Bart on 3/4/20.
//

import Foundation

class Networking {
    
    private let googleNewsAPIKey = "57fd062826eb4196b020535fe631778d"
    
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
                print("RESPONSE ERROR")
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
}
