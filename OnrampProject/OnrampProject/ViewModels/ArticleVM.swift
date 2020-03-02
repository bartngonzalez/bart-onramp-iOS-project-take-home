//
//  ArticleVM.swift
//  OnrampProject
//
//  Created by Bart on 2/29/20.
//

import Foundation

struct ArticleVM: Codable {
    
    // MARK: JSON root
    var status: String?
    var totalResults: Int?
    var articles: [Article]?
    
    // MARK: JSON root -> articles
    var id: String?
    var name: String?
    var title: String?
    var url: String?
    var author: String?
    var urlToImage: String?
    var publishedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case totalResults = "totalResults"
        case articles = "articles"
        case publishedAt = "publishedAt"
    }
    
    // MARK: Decode json and set root's data
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decode(String.self, forKey: .status)
        self.totalResults = try container.decode(Int.self, forKey: .totalResults)
        self.articles = try container.decode([Article].self, forKey: .articles)
    }
    
    // MARK: set article's data with respective data
    init(article: Article) {
        self.id = article.source.id ?? "id missing"
        self.name = article.source.name ?? "name missing"
        self.author = article.author ?? "author missing"
        self.title = article.title ?? "title missing"
        self.url = article.url ?? "url missing"
        self.urlToImage = article.urlToImage ?? "urlToImage missing"
        self.publishedAt = dateFormatter(publishedAt: article.publishedAt)
    }
    
    // TODO: dateFormatter should consider seconds and minutes in case the time is less than an hour
    func dateFormatter(publishedAt: Date) -> String {
        let currentDate = Date()
        let hourDifference = Calendar.current.dateComponents([.hour], from: publishedAt, to: currentDate)
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = .hour
        
        if Int(formatter.string(from: hourDifference)!)! > 24 {
            return "24+ hours ago"
        }
        
        return "\(formatter.string(from: hourDifference)!) hours ago"
    }
}
