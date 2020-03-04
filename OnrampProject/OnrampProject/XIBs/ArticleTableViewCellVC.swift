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
        
        self.articleImageView.layer.cornerRadius = 7
    }
    
    // MARK: function allows the HeadlinesVC set the IBOutlet's with the articles located in HeadlinesVC
    func setArticles(article: ArticleVM) {
        // TODO: set articleImageView with urlToImage in Article struct.
        self.articleAuthorNameLabel.text = article.author
        self.articleTitleLabel.text = article.title
        self.articleSourceLabel.text = article.name
        self.articlePublishDateLabel.text = article.publishedAt
    }
    
    // TODO: implement function into ArticleVM. Function should have placeHolder parameter to display a temporarily image .Function should NSCache<NSString, UIImage>() to not request existing images.
    func setImageFromURL(url: String) {
        
        print("setImageFromURL(url: String)")
        
        if let url = URL(string: url) {
            print("url: \(url)")
            let session = URLSession.shared
            
            session.dataTask(with: url) { (data, response, error) in
                print("session.dataTask(...)")
                
                if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    print(response)
                    print("statusCode: \(response.statusCode)")
                } else {
                    print("setImageFromURL(url: String) - FAILD")
                    /*
                    DispatchQueue.main.async {
                        self.articleImageView.image = placeHolderImage
                    }
                    */
                }
                DispatchQueue.main.async {
                    print("DispatchQueue.main.async")
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            self.articleImageView.image = downloadedImage
                        }
                    }
                }
            }.resume()
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
