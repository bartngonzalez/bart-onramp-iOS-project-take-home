//
//  TopicsTableViewCellVC.swift
//  OnrampProject
//
//  Created by Bart on 3/2/20.
//

import UIKit

class TopicsTableViewCellVC: UITableViewCell {

    @IBOutlet weak var topicsCollectionView: UICollectionView!
    
    var referenceHeadlinesVC: HeadlinesVC!
    let topics: [String] = ["BUSINESS", "TECHNOLOGY", "SPORTS", "SCIENCE", "HEALTH"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        topicsCollectionView.delegate = self
        topicsCollectionView.dataSource = self
        
        let topicsCollectionViewCell = UINib(nibName: "TopicCollectionViewCell", bundle: nil)
        topicsCollectionView.register(topicsCollectionViewCell, forCellWithReuseIdentifier: "topicCollectionViewCellXIB")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

// MARK: UICollectionView Protocol's config
extension TopicsTableViewCellVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        topics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = topicsCollectionView.dequeueReusableCell(withReuseIdentifier: "topicCollectionViewCellXIB", for: indexPath) as! TopicCollectionViewCellVC
        let topic = topics[indexPath.row]
        
        cell.configCell(topic: topic)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let topic = topics[indexPath.row]
        let topicURL = "https://newsapi.org/v2/top-headlines?category=\(topic)&country=us&pageSize=20&apiKey="
        referenceHeadlinesVC.googleNewsAPI(topicURL: topicURL)
    }
}
