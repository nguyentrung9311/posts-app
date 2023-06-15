//
//  PostCell.swift
//  PostsApp
//
//  Created by TrungNV (Macbook) on 14/06/2023.
//

import UIKit

class PostCell: UITableViewCell {
    static let id = "PostCell"
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var ivAvatar: UIImageView!
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbContent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setPostData(postData: PostData) {
        DispatchQueue.global().async {
            if let url = URL(string: postData.author?.profile?.avatar ?? "") {
                let data = try? Data(contentsOf: url)
                DispatchQueue.main.async { [weak self] in
                    self?.ivAvatar.image = UIImage(data: data!)
                }
            }
        }

        lbName.text = postData.author?.username ?? ""
        lbDate.text = postData.updatedAt ?? ""
        lbTitle.text = postData.title ?? ""
        lbContent.text = postData.content ?? ""
        ivAvatar.layer.cornerRadius = ivAvatar.bounds.width / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onPinClicked(_ sender: Any) {
        
    }
}
