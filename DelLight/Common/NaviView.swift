//
//  NaviView.swift
//  DEl Lite
//
//  Created by 강동영 on 2022/09/21.
//

import UIKit
import SnapKit

@IBDesignable
class NaviView: UIView {
    
    var defaultColor: UIColor {
        return UIColor(red: 139/255, green: 195/255, blue: 74/255, alpha: 1)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        self.addTopView()
        self.backgroundColor = defaultColor
        self.layer.masksToBounds = false
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        backgroundColor = defaultColor
    }
    
    private func addTopView() {
        let topView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 50))
        topView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(topView)
        topView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        topView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor).isActive = true
        topView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor).isActive = true
        topView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        
        topView.backgroundColor = defaultColor
        
    }
    
    var useBackButton: Bool = false

}
