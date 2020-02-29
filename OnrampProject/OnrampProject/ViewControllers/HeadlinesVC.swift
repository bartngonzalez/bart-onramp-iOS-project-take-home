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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = headlinesTableView.dequeueReusableCell(withIdentifier: "articleCellXIB") as! ArticleTableViewCellVC
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        headlinesTableView.deselectRow(at: indexPath, animated: true)
    }
}
