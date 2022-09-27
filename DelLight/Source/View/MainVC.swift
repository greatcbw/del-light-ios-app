//
//  ViewController.swift
//  DelLight
//
//  Created by 강동영 on 2022/09/19.
//

import UIKit
import RxSwift
import RxCocoa
//import ReactorKit
//import SnapKit

class MainVC: UIViewController {

    @IBOutlet weak var searchBLEButton: UIButton!
    
    var viewModel: MainVMAvailable?
    private var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindComponent()
    }

    private func bindComponent() {
        
        searchBLEButton
            .rx
            .tap
            .throttle(.milliseconds(500), latest: false, scheduler: MainScheduler.instance)
            .subscribe { _ in
                guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegistBLEVC") else { return }
                self.navigationController?.pushViewController(vc, animated: true)
            }.disposed(by: bag)
    }

}

