//
//  TutorialCell.swift
//  Posts App
//
//  Created by TrungNV (Macbook) on 01/06/2023.
//

import UIKit

class TutorialCell: UICollectionViewCell {
    static let cellId = "TutorialCell"
    
    @IBOutlet weak var ivTutorial: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbContent: UILabel!
    @IBOutlet weak var btSkip: UIButton!
    
    var index: IndexPath!
    
    var tutorialCellDelegate: TutorialCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initViews()
    }
    
    private func initViews() {
        btSkip.tintColor = #colorLiteral(red: 0.002089498332, green: 0.6882188916, blue: 0.9444032311, alpha: 1)
        btSkip.layer.borderColor = #colorLiteral(red: 0.002089498332, green: 0.6882188916, blue: 0.9444032311, alpha: 1)
        btSkip.layer.borderWidth = 1.5
        btSkip.layer.cornerRadius = 6
    }
    
    func initTutorialOne() {
        ivTutorial.image = UIImage(named: "tutorial_1")
        lbTitle.text = "Welcome to Techmaster"
        lbContent.text = "Học là có việc"
    }
    
    func initTutorialTwo() {
        ivTutorial.image = UIImage(named: "tutorial_2")
        lbTitle.text = "Lớp iOS Nâng Cao - iOS 08"
        lbContent.text = "Học là có việc"
    }
    
    func initTutorialThree() {
        ivTutorial.image = UIImage(named: "tutorial_3")
        lbTitle.text = "Nâng cao giá trị bản thân"
        lbContent.text = "Làm những gì mình thích"
        btSkip.setTitle("Start", for: UIControl.State.normal)
    }

    @IBAction func onSkipClicked(_ sender: Any) {
        tutorialCellDelegate?.onSkipClicked(index)
    }
}
