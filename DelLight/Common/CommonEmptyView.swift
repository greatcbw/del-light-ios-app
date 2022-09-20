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
    
    let emptyLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInitialization()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.commonInitialization()
    }
    
    func commonInitialization() {
        let view: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 375, height: 89))
        
        emptyLabel.numberOfLines = 0
        emptyLabel.lineBreakMode = .byWordWrapping
        emptyLabel.textAlignment = .center
        emptyLabel.text = "등록된 조명이 없습니다.\n화면 아래의 버튼을 눌러 조명을 검색하세요."
        emptyLabel.sizeToFit()
        view.addSubview(emptyLabel)
        
        emptyLabel.snp.makeConstraints { make in
            make.center.equalTo(view)
        }

        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
   
}
