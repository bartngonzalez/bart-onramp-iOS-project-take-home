//
//  HeadlinesVC.swift
//  OnrampProject
//
//  Created by Bart on 2/28/20.
//

import UIKit

class HeadlinesVC: UITableViewController {
    
    @IBOutlet var headlinesTableView: UITableView!
    
    var articles: [ArticleVM] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("HeadlinesVC: viewDidLoad()")
        
        headlinesTableView.delegate = self
        headlinesTableView.dataSource = self
        
        let articleTableViewCellXIB = UINib(nibName: "ArticleTableViewCell", bundle: nil)
        headlinesTableView.register(articleTableViewCellXIB, forCellReuseIdentifier: "articleCellXIB")
        
        newsAPI()
    }
    
    func newsAPI() {
        
        print("newsAPI()")
        
        let headers = [
            "Content-Type": "application/json",
        ]
        
        var request = URLRequest(url: URL(string: "https://newsapi.org/v2/top-headlines?category=business&country=us&pageSize=3&apiKey=c87414d33d46453e8ffb0fa7e5648cd7")!)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        
        session.dataTask(with: request) { (data, response, error) in
            
            if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                print(response)
                print("statusCode: \(response.statusCode)")
            } else {
                print("newsAPI() - Faild")
                return
            }
            
            if let data = data {
                let decoder = JSONDecoder()
                
                do {
                    let articleVM = try decoder.decode(ArticleVM.self, from: data)
                    // print(articleVM.status)
                    // print(articleVM.totalResults)
                    self.articles = articleVM.articles?.map({return ArticleVM(article: $0)}) ?? []
                    for x in self.articles {
                        print(x.author)
                        print(x.id)
                    }
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
    
    func createArticles(articles: [[String: Any]]) {
        
    }
    
    func scrollToTop() {
        
        print("scrollToTop()")
        
        headlinesTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 30
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = headlinesTableView.dequeueReusableCell(withIdentifier: "articleCellXIB") as! ArticleTableViewCellVC
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        headlinesTableView.deselectRow(at: indexPath, animated: true)
        scrollToTop()
    }
}
