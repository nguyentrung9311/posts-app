//
//  TutorialViewController.swift
//  Posts App
//
//  Created by TrungNV (Macbook) on 01/06/2023.
//

import UIKit

class TutorialViewController: UIViewController, TutorialCellDelegate {
    @IBOutlet weak var cvTutorial: UICollectionView!
    var currentIndex = IndexPath(row: 0, section: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initCollectionView()
    }
    
    private func initCollectionView() {
        cvTutorial.dataSource = self
        cvTutorial.delegate = self
        
        if let flowLayout = cvTutorial.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.minimumLineSpacing = 0
            flowLayout.minimumInteritemSpacing = 0
            flowLayout.scrollDirection = .horizontal
        }
        
        cvTutorial.isPagingEnabled = true
        cvTutorial.showsHorizontalScrollIndicator = false
        cvTutorial.contentInsetAdjustmentBehavior = .never
        
        cvTutorial.register(UINib.init(nibName: TutorialCell.cellId, bundle: nil), forCellWithReuseIdentifier: TutorialCell.cellId)
    }
    
    func onSkipClicked(_ index: IndexPath) {
        let indexPath = IndexPath(row: index.row + 1, section: 0)
        if indexPath.row < 3 {
            cvTutorial.scrollRectToVisible(CGRect(x: view.bounds.width * CGFloat(indexPath.row), y: 0, width: view.bounds.width, height: UIScreen.main.bounds.height), animated: true)
        } else {
            UserDefaultHelper.shared.tutorialCompleted = true
            
            let loginVC = LoginViewController()
            
            navigationController?.pushViewController(loginVC, animated: true)
        }
    }
}

extension TutorialViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let tutorialCell = collectionView.dequeueReusableCell(withReuseIdentifier: TutorialCell.cellId, for: indexPath) as! TutorialCell
        tutorialCell.tutorialCellDelegate = self
        tutorialCell.index = indexPath
        
        switch indexPath.row {
        case 0:
            tutorialCell.initTutorialOne()
            break
        case 1:
            tutorialCell.initTutorialTwo()
            break
        case 2:
            tutorialCell.initTutorialThree()
            break
        default: break
        }
        return tutorialCell
    }
}

extension TutorialViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currentIndex = IndexPath(row: Int(cvTutorial.contentOffset.x / UIScreen.main.bounds.width), section: 0)
    }
}
