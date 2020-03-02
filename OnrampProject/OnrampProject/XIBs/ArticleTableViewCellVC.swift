//
//  ArticleTableViewCellVC.swift
//  OnrampProject
//
//  Created by Bart on 2/28/20.
//

import UIKit

class ArticleTableViewCellVC: UITableViewCell {
    
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var articleAuthorNameLabel: UILabel!
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var articleSourceLabel: UILabel!
    @IBOutlet weak var articlePublishDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: function allows the HeadlinesVC set the IBOutlet's with the articles located in HeadlinesVC
    func setArticles(article: ArticleVM) {
        self.articleAuthorNameLabel.text = article.author
        self.articleTitleLabel.text = article.title
        self.articleSourceLabel.text = article.name
        self.articlePublishDateLabel.text = article.publishedAt
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
