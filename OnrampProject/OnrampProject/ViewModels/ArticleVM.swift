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
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decode(String.self, forKey: .status)
        self.totalResults = try container.decode(Int.self, forKey: .totalResults)
        self.articles = try container.decode([Article].self, forKey: .articles)
    }
    
    init(article: Article) {
        self.id = article.source.id ?? "id missing"
        self.name = article.source.name ?? "name missing"
        self.author = article.author ?? "author missing"
        self.title = article.title ?? "title missing"
        self.url = article.url ?? "url missing"
        self.urlToImage = article.urlToImage ?? "urlToImage missing"
        self.publishedAt = article.publishedAt ?? "publishedAt missing"
    }
}
