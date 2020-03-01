//
//  ArticleVM.swift
//  OnrampProject
//
//  Created by Bart on 2/29/20.
//

struct ArticleVM: Codable {
    
    var status: String?
    var totalResults: Int?
    var articles: [Article]?
    
    var author: String?
    var id: String?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case totalResults = "totalResults"
        case articles = "articles"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decode(String.self, forKey: .status)
        self.totalResults = try container.decode(Int.self, forKey: .totalResults)
        self.articles = try container.decode([Article].self, forKey: .articles)
    }
    
    init(article: Article) {
        self.id = article.source.id
        self.author = article.author
    }
}
