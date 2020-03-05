//
//  Location.swift
//  OnrampProject
//
//  Created by Bart on 3/4/20.
//

import Foundation

struct Location: Codable {
    
    struct Components: Codable {
        let city: String?
    }
    
    let components: Components
}
