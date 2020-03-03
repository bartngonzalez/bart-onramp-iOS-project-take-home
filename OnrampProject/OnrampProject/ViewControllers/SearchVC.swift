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
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        print(searchText)
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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let article = articles[indexPath.row]
        let cell = searchTableView.dequeueReusableCell(withIdentifier: "") as! ArticleTableViewCellVC
        
        cell.setArticles(article: article)
        cell.setImageFromURL(url: article.urlToImage!)
        
        return cell
    }
}
