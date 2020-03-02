//
//  Article.swift
//  OnrampProject
//
//  Created by Bart on 2/28/20.
//

import Foundation

struct Article: Codable {
    
    // MARK: Codable: access Source object data
    struct Source: Codable {
        let id: String?
        let name: String?
    }
    
    // MARK: Article's root data
    let source: Source
    let author: String?
    let title: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: Date
}
