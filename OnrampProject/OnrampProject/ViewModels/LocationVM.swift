//
//  LocationVM.swift
//  OnrampProject
//
//  Created by Bart on 3/4/20.
//

import Foundation

struct LocationVM: Codable {
    
    // MARK: JSON root
    var results: [Location]?
    
    var city: String?
    
    enum CodingKeys: String, CodingKey {
        case results = "results"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.results = try container.decode([Location].self, forKey: .results)
    }
    
    init(result: Location) {
        self.city = result.components.city
    }
}
