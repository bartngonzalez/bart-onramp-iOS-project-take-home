//
//  SearchVC.swift
//  OnrampProject
//
//  Created by Bart on 3/2/20.
//

import UIKit
import SafariServices

class SearchVC: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var searchTableView: UITableView!
    
    var responseStatusCode: Int = 0
    var articles: [ArticleVM] = []
    let networking = Networking()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("SearchVC: viewDidLoad()")
        
        self.title = "Search"
        
        // UISearchBar
        searchBar.delegate = self
        
        // UITableView
        searchTableView.delegate = self
        searchTableView.dataSource = self
        
        // XIB
        let articleTableViewCellXIB = UINib(nibName: "ArticleTableViewCell", bundle: nil)
        searchTableView.register(articleTableViewCellXIB, forCellReuseIdentifier: "articleCellXIB")
    }
    
    // MARK: SearchBar calls googleNewsAPI(searchBarInput: String)
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let url = "http://newsapi.org/v2/everything?q=\(searchText)&pageSize=30&apiKey="
        googleNewsAPI(searchBarInput: url)
    }
    
    // MARK: Google News API from Networking.swift
    func googleNewsAPI(searchBarInput: String) {
        
        networking.googleNewsAPI(url: searchBarInput) { (result) in
            
            switch result {
            case .success(let json):
                self.responseStatusCode = 200
                self.articles = json.articles?.map({return ArticleVM(article: $0)}) ?? []
                DispatchQueue.main.async {
                    self.searchTableView.reloadData()
                }
            case .failure(let error):
                print("Faild to get articles:", error)
                self.responseStatusCode = 0
            }
        }
    }
}

// MARK: UITableView Protocol config 
extension SearchVC: SFSafariViewControllerDelegate {
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
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        searchTableView.deselectRow(at: indexPath, animated: true)
        
        if let url = URL(string: articles[indexPath.row].url!) {
            let vc = SFSafariViewController(url: url)
            vc.delegate = self
            present(vc, animated: true)
        }
    }
}
