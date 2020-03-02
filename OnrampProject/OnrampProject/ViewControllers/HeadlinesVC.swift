//
//  HeadlinesVC.swift
//  OnrampProject
//
//  Created by Bart on 2/28/20.
//

import UIKit
import SafariServices

class HeadlinesVC: UITableViewController, SFSafariViewControllerDelegate {
    
    @IBOutlet var headlinesTableView: UITableView!
    
    var responseStatusCode: Int = 0
    var articles: [ArticleVM] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("HeadlinesVC: viewDidLoad()")
        
        self.title = "Headlines"
        
        // MARK: UITableView's
        headlinesTableView.delegate = self
        headlinesTableView.dataSource = self
        
        // MARK: XIB's
        let topicsTableViewCellXIB = UINib(nibName: "TopicsTableViewCell", bundle: nil)
        let articleTableViewCellXIB = UINib(nibName: "ArticleTableViewCell", bundle: nil)
        headlinesTableView.register(topicsTableViewCellXIB, forCellReuseIdentifier: "topicsCellXIB")
        headlinesTableView.register(articleTableViewCellXIB, forCellReuseIdentifier: "articleCellXIB")
        
        newsAPI()
    }
    
    // TODO: Should move newsAPI a Networking.swift file
    func newsAPI() {
        
        print("newsAPI()")
        
        let headers = [
            "Content-Type": "application/json",
        ]
        
        var request = URLRequest(url: URL(string: "https://newsapi.org/v2/top-headlines?category=business&country=us&pageSize=20&apiKey=c87414d33d46453e8ffb0fa7e5648cd7")!)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        
        session.dataTask(with: request) { (data, response, error) in
            
            if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                print(response)
                print("statusCode: \(response.statusCode)")
                self.responseStatusCode = response.statusCode
            } else {
                print("newsAPI() - Faild")
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
                        self.headlinesTableView.reloadData()
                    }
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
    
    func scrollToTop() {
        
        print("scrollToTop()")
        
        headlinesTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
}

extension HeadlinesVC {
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        if responseStatusCode == 200 {
            return 2
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        } else if section == 1 {
            return self.articles.count
        }
        return 0
    }
    
    // MARK: Set nib's to their respective sections
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = headlinesTableView.dequeueReusableCell(withIdentifier: "topicsCellXIB") as! TopicsTableViewCellVC
            
            return cell
        } else if indexPath.section == 1 {
            let article = articles[indexPath.row]
            let cell = headlinesTableView.dequeueReusableCell(withIdentifier: "articleCellXIB") as! ArticleTableViewCellVC
            
            cell.setArticles(article: article)
            cell.setImageFromURL(url: article.urlToImage!)
            
            return cell
        }
        
        let cell = headlinesTableView.dequeueReusableCell(withIdentifier: "articleCellXIB") as! ArticleTableViewCellVC
        
        return cell
    }
    
    // MARK: Only open SafariVC if user selects cell within section 1 (articles section)
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("deselectRow(at: indexPath, animated: true)")
        
        headlinesTableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 1 {
            if let url = URL(string: articles[indexPath.row].url!) {
                let vc = SFSafariViewController(url: url)
                vc.delegate = self
                present(vc, animated: true)
            }
        }
    }
}
