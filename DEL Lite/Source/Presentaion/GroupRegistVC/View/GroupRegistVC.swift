//
//  GroupRegistVC.swift
//  DEL Lite
//
//  Created by 강동영 on 2022/10/10.
//

import UIKit
import RxSwift

class GroupRegistVC: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var addGroupButton: UIButton!
    @IBOutlet weak var groupTableview: UITableView!
    
    private var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bindComponent()
        configureTableView()
    }
    
    private func bindComponent() {
        
        backButton
            .rx
            .tap
            .observe(on: MainScheduler.instance)
            .subscribe { _ in
                self.navigationController?.popViewController(animated: true)
            }.disposed(by: bag)
        
        addGroupButton
            .rx
            .tap
            .observe(on: MainScheduler.instance)
            .subscribe { _ in
                self.createGroup()
            }.disposed(by: bag)
    }
    
    private func configureTableView() {
        
        groupTableview.delegate = self
        groupTableview.dataSource = self
        groupTableview.rowHeight = UITableView.automaticDimension
    }
    
    func createGroup() {
        
        let alert = UIAlertController(title: "Add Group".localized, message: nil, preferredStyle: .alert)
        
        alert.addTextField { tf in
            tf.placeholder = "Please enter a group name.".localized
        }
        
        let okAction = UIAlertAction(title: "Confirm".localized, style: .default) { action in
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: false)
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource Method
extension GroupRegistVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupListCell")!
        guard let convertedCell = cell as? GroupListCell else { return cell }
        
        return cell
    }
    
    
}
