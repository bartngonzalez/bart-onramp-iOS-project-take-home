//
//  SearchVC.swift
//  OnrampProject
//
//  Created by Bart on 3/2/20.
//

import UIKit

class SearchVC: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var searchTableView: UITableView!
    
    var responseStatusCode: Int = 0
    var articles: [ArticleVM] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("SearchVC: viewDidLoad()")
        
        // UISearchBar
        searchBar.delegate = self
        
        // UITableView
        searchTableView.delegate = self
        searchTableView.dataSource = self
        
        // XIB
        let articleTableViewCellXIB = UINib(nibName: "ArticleTableViewCell", bundle: nil)
        searchTableView.register(articleTableViewCellXIB, forCellReuseIdentifier: "articleCellXIB")
    }
    
    // TODO: Bug when user enters a space
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        print(searchText)
        
        searchNewsAPI(input: searchText)
    }
    
    func searchNewsAPI(input: String) {
        
        print("searchNewsAPI()")
        
        let headers = [
            "Content-Type": "application/json"
        ]
        
        // TODO: Input is nil when user enters a space
        var request = URLRequest(url: URL(string: "http://newsapi.org/v2/everything?q=\(input)&pageSize=30&apiKey=c87414d33d46453e8ffb0fa7e5648cd7")!)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        
        session.dataTask(with: request) { (data, response, errir) in
            
            if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                print(response)
                print("statusCode: \(response.statusCode)")
                self.responseStatusCode = response.statusCode
            } else {
                print("searchNewsAPI - FAILD")
                return
            }
            
            if let data = data {
                let decoder = JSONDecoder()
                
                do {
                    decoder.dateDecodingStrategy = .iso8601
                    let json = try decoder.decode(ArticleVM.self, from: data)
                    print(json.status!)
                    print(json.totalResults!)
                    self.articles = json.articles?.map({return ArticleVM(article: $0)}) ?? []
                    for x in self.articles {
                        print(x.id!)
                        print(x.name!)
                        print(x.author!)
                        print(x.title!)
                        print(x.url!)
                        print(x.urlToImage!)
                        print(x.publishedAt!)
                    }
                    
                    DispatchQueue.main.async {
                        self.searchTableView.reloadData()
                    }
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
}

extension SearchVC {
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        if responseStatusCode == 200 {
            return 1
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.articles.count
    }
    
    // TODO: If user types fast the table view index gets out of range.s
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let article = articles[indexPath.row]
        let cell = searchTableView.dequeueReusableCell(withIdentifier: "articleCellXIB") as! ArticleTableViewCellVC
        
        cell.setArticles(article: article)
        cell.setImageFromURL(url: article.urlToImage!)
        
        return cell
    }
}
