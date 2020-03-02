//
//  TopicsTableViewCellVC.swift
//  OnrampProject
//
//  Created by Bart on 3/2/20.
//

import UIKit

class TopicsTableViewCellVC: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var topicsCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        topicsCollectionView.delegate = self
        topicsCollectionView.dataSource = self
        
        let topicsCollectionViewCell = UINib(nibName: "TopicCollectionViewCell", bundle: nil)
        topicsCollectionView.register(topicsCollectionViewCell, forCellWithReuseIdentifier: "topicCollectionViewCellXIB")
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = topicsCollectionView.dequeueReusableCell(withReuseIdentifier: "topicCollectionViewCellXIB", for: indexPath) as! TopicCollectionViewCellVC
        
        return cell
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
