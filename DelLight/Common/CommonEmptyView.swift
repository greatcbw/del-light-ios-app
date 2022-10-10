//
//  CommonEmptyView.swift
//  DelLight
//
//  Created by 강동영 on 2022/09/21.
//

import UIKit
import SnapKit
/**
 조회 내역 없을 때 공통으로 사용하는 뷰
 */
class NoneSearchDataTableViewFooter:UIView{
    
    lazy var emptyLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.textColor = .darkGray
        label.sizeToFit()
        
        return label
    }()
    
    let view: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 375, height: 89))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInitialization()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.commonInitialization()
    }
    
    func commonInitialization() {
        
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    func mainVCEmptyLabel() {
        
        emptyLabel.text = "There are no registered lights.\nClick the button at the bottom of the screen to search for lights.".localized
        view.addSubview(emptyLabel)
        
        emptyLabel.snp.makeConstraints { make in
            make.center.equalTo(view)
        }
    }
   
}
