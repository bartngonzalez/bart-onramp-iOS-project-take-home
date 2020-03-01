//
//  Article.swift
//  OnrampProject
//
//  Created by Bart on 2/28/20.
//

struct Article: Codable {
    
    struct Source: Codable {
        let id: String?
        let name: String?
    }
    
    let source: Source
    let author: String?
    let title: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String
}
