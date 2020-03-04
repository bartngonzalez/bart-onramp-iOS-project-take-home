//
//  TopicCollectionViewCellVC.swift
//  OnrampProject
//
//  Created by Bart on 3/2/20.
//

import UIKit

class TopicCollectionViewCellVC: UICollectionViewCell {
    
    @IBOutlet weak var topicImage: UIImageView!
    @IBOutlet weak var topicTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 7
    }
    
    func configCell(topic: String) {
        self.topicImage.image = UIImage(named: "\(topic.lowercased())-icon")
        self.topicTitle.text = topic
    }
}
