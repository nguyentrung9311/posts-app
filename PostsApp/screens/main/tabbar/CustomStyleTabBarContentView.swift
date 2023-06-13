//
//  CustomStyleTabBarContentView.swift
//  PostsApp
//
//  Created by Hà Văn Đức on 03/06/2023.
//

import Foundation
import ESTabBarController_swift

class CustomStyleTabBarContentView: ESTabBarItemContentView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        /// Normal
        textColor = UIColor.gray
        iconColor = UIColor.gray
        
        /// Selected
        highlightTextColor = UIColor.white
        highlightIconColor = UIColor.white
    }
    
//    override var selected: Bool {
//        didSet {
//            super.selected = selected
//            self.updateLayout()
//        }
//    }
//
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
