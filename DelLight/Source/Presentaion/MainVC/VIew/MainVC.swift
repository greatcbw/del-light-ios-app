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

    @IBOutlet weak var manageHStackView: UIStackView!
    @IBOutlet weak var scheduleView: UIView!
    @IBOutlet weak var groupManageView: UIView!
    @IBOutlet weak var groupDeleteView: UIView!
    @IBOutlet weak var scheduleButton: UIButton!
    @IBOutlet weak var groupManageButton: UIButton!
    @IBOutlet weak var groupDeleteButton: UIButton!
    @IBOutlet weak var registedTableview: UITableView!
    @IBOutlet weak var searchBLEButton: UIButton!
    
    var viewModel: MainVMAvailable?
    private var bag = DisposeBag()
    /// 풋터뷰 - 없을때만
    private var footerView: NoneSearchDataTableViewFooter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initLayout()
        configureTableview()
        bindComponent()
    }

    private func initLayout() {
        
        scheduleView.layer.borderWidth = 1
        groupManageView.layer.borderWidth = 1
        groupDeleteView.layer.borderWidth = 1
        scheduleView.layer.borderColor = UIColor.black.cgColor
        groupManageView.layer.borderColor = UIColor.black.cgColor
        groupDeleteView.layer.borderColor = UIColor.black.cgColor
        
        scheduleButton.addTarget(self, action: #selector(schedule), for: .touchUpInside)
        groupManageButton.addTarget(self, action: #selector(manageGroup), for: .touchUpInside)
        groupDeleteButton.addTarget(self, action: #selector(deleteGroup), for: .touchUpInside)
        
        footerView = NoneSearchDataTableViewFooter(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200))
        footerView?.mainVCEmptyLabel()
    }
    
    @objc func schedule() {
        print("schedule")
    }
    
    @objc func manageGroup() {
        print("manageGroup")
    }
    
    @objc func deleteGroup() {
        print("deleteGroup")
    }

    private func configureTableview() {
        
        registedTableview.delegate = self
        registedTableview.dataSource = self
        registedTableview.rowHeight = 150//UITableView.automaticDimension
    }
    private func bindComponent() {
        
        searchBLEButton
            .rx
            .tap
            .throttle(.milliseconds(500), latest: false, scheduler: MainScheduler.instance)
            .subscribe { _ in
                guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "SearchBLEVC") else { return }
                self.navigationController?.pushViewController(vc, animated: true)
            }.disposed(by: bag)
    }

}

// MARK: UITableViewDataSource, UITableViewDelegate
extension MainVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = 3
        
        DispatchQueue.main.async {
            switch count == 0 {
            case true:
                tableView.tableFooterView = self.footerView
                //self.manageHStackView.isHidden = false
            case false:
                tableView.tableFooterView = nil
                //self.manageHStackView.isHidden = true
            }
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainGroupListCell")!
        
        return cell
    }
    
    
}
