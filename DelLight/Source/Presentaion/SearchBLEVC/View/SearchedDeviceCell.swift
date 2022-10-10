//
//  SearchedDeviceCell.swift
//  DEL Lite
//
//  Created by 강동영 on 2022/10/10.
//

import UIKit
import RxSwift
import RxCocoa

class SearchedDeviceCell: UITableViewCell {

    @IBOutlet weak var registSwitch: UISwitch!
    @IBOutlet weak var deviceName: UILabel!
    @IBOutlet weak var deviceUUID: UILabel!
    @IBOutlet weak var deviceRSSI: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var registButton: UIButton!
    
    private var bag = DisposeBag()
    var delegate: RegistCellAction?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bindComponent()
        refreshButton.addTarget(self, action: #selector(refreshList), for: .touchUpInside)
        registButton.addTarget(self, action: #selector(moveToRegistVC), for: .touchUpInside)
        refreshButton.isHidden = false
        registButton.isHidden = true
    }
    
    @objc func refreshList() {
        delegate?.refresh()
    }
    
    @objc func moveToRegistVC() {
        delegate?.goRegist()
    }
    
    override func prepareForReuse() {
        
    }

    func bindComponent() {
        
        registSwitch
            .rx
            .isOn
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { isOn in
                print("value = \(isOn)")
                self.refreshButton.isHidden = isOn
                self.registButton.isHidden = !isOn
            }).disposed(by: bag)
    }
    
    func setItem() {
        
    }

}

protocol RegistCellAction {
    
    func refresh()
    func goRegist()
}
