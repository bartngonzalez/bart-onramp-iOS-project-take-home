//
//  Article.swift
//  OnrampProject
//
//  Created by Bart on 2/28/20.
//

struct Article {
    
    let sourceId: String
    let sourceName: String
    let author: String
    let title: String
    let articleUrl: String
    let urlToImage: String
    let publishedAt: String
    
    init(sourceId: String, sourceName: String, author: String, title: String, articleUrl: String, urlToImage: String, publishedAt: String) {
        
        self.sourceId = sourceId
        self.sourceName = sourceName
        self.author = author
        self.title = title
        self.articleUrl = articleUrl
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
    }
}
