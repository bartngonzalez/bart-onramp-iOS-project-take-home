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
    let networking = Networking()
    var topicURL: String = "https://newsapi.org/v2/top-headlines?category=business&country=us&pageSize=20&apiKey="
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("HeadlinesVC: viewDidLoad()")
        
        self.title = "Headlines"
        
        // UITableView's
        headlinesTableView.delegate = self
        headlinesTableView.dataSource = self
        
        // XIB's
        let topicsTableViewCellXIB = UINib(nibName: "TopicsTableViewCell", bundle: nil)
        let articleTableViewCellXIB = UINib(nibName: "ArticleTableViewCell", bundle: nil)
        headlinesTableView.register(topicsTableViewCellXIB, forCellReuseIdentifier: "topicsCellXIB")
        headlinesTableView.register(articleTableViewCellXIB, forCellReuseIdentifier: "articleCellXIB")
        
        // Call API
        googleNewsAPI(topicURL: topicURL)
    }
    
    // MARK: Google News API from Networking.swift
    func googleNewsAPI(topicURL: String) {
        
        networking.googleNewsAPI(url: topicURL) { (result) in
            switch result {
            case .success(let json):
                self.responseStatusCode = 200
                self.articles = json.articles?.map({return ArticleVM(article: $0)}) ?? []
                DispatchQueue.main.async {
                    self.headlinesTableView.reloadData()
                }
            case .failure(let error):
                print("Failed to get articles:", error)
                self.responseStatusCode = 0
            }
        }
    }
    
    func scrollToTop() {
        
        print("scrollToTop()")
        
        headlinesTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
    
    @IBAction func presentSearchVC(_ sender: Any) {
        
        print("presentSearchVC")
        
        let storyboard = UIStoryboard(name: "Search", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SearchSB") as! SearchVC
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: UITableView Protocol config
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
            
            cell.referenceHeadlinesVC = self
            
            return cell
        } else if indexPath.section == 1 {
            let article = articles[indexPath.row]
            let cell = headlinesTableView.dequeueReusableCell(withIdentifier: "articleCellXIB") as! ArticleTableViewCellVC
            
            cell.setArticles(article: article)
            
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
