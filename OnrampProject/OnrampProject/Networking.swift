//
//  Networking.swift
//  OnrampProject
//
//  Created by Bart on 3/4/20.
//

import Foundation

class Networking {
    
    // MARK: Google News API for MyNewsVC, HeadlinsVC and SearchVC articles.
    func googleNewsAPI(url: String, completion: @escaping (Result<ArticleVM, Error>) -> ()) {
        
        let headers = [
            "Content-Type": "application/json"
        ]
        
        var request = URLRequest(url: URL(string: url)!)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        
        session.dataTask(with: request) { (data, response, error) in
            
            if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                print(response)
            } else {
                completion(.failure(error!))
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
