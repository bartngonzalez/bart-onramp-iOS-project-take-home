//
//  HeadlinesVC.swift
//  OnrampProject
//
//  Created by Bart on 2/28/20.
//

import UIKit

class HeadlinesVC: UITableViewController {
    
    @IBOutlet var headlinesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("HeadlinesVC: viewDidLoad()")
        
        headlinesTableView.delegate = self
        headlinesTableView.dataSource = self
        
        let articleTableViewCellXIB = UINib(nibName: "ArticleTableViewCell", bundle: nil)
        headlinesTableView.register(articleTableViewCellXIB, forCellReuseIdentifier: "articleCellXIB")
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
