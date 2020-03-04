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
        // Initialization code
    }
    
    func configCell(topic: String) {
        self.topicTitle.text = topic
    }
}
