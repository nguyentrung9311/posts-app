//
//  PostCell.swift
//  PostsApp
//
//  Created by TrungNV (Macbook) on 14/06/2023.
//

import UIKit

class PostCell: UITableViewCell {
    static let id = "PostCell"
    @IBOutlet weak var lbTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setPostData(postData: PostData) {
        lbTitle.text = postData.title
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
