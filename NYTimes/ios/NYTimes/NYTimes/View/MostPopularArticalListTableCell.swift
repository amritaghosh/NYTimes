//
//  MostPopularArticleListTableCell.swift
//  NYTimes
//
//  Created by Amrita Ghosh on 22/07/19.
//  Copyright © 2019 Amrita Ghosh. All rights reserved.
//

import UIKit

class MostPopularArticleListTableCell: UITableViewCell {
    
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleByLine: UILabel!
    @IBOutlet weak var articledate: UILabel!
    @IBOutlet weak var articleImg: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureCellUsingModel(_ articleList : ArticleList) {
        self.articleImg.layer.borderColor = #colorLiteral(red: 0.7233663201, green: 0.7233663201, blue: 0.7233663201, alpha: 0.25)
        articleTitle.text = articleList.title
        articleByLine.text = articleList.byline
        articledate.text = articleList.published_date
    }
    
}


