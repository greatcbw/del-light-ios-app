//
//  SearchBLEVC.swift
//  DEL Lite
//
//  Created by 강동영 on 2022/09/26.
//

import UIKit
import RxSwift
import CoreBluetooth
import os

class SearchBLEVC: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var deviceTableview: UITableView!
    
    private var bag = DisposeBag()
    
    var centralManager: CBCentralManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        centralManager = CBCentralManager(delegate: self, queue: nil, options: [CBCentralManagerOptionShowPowerAlertKey: true])
        
        configureTableView()
        bindComponent()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        centralManager.stopScan()
        os_log("Scanning stopped")
    }
    
    private func configureTableView() {
        
        deviceTableview.delegate = self
        deviceTableview.dataSource = self
        deviceTableview.rowHeight = UITableView.automaticDimension
    }
    
    private func bindComponent() {
        
        backButton
            .rx
            .tap
            .observe(on: MainScheduler.instance)
            .subscribe { _ in
                self.navigationController?.popViewController(animated: true)
            }.disposed(by: bag)
    }


}

extension SearchBLEVC: CBCentralManagerDelegate, CBPeripheralDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            // ... so start working with the peripheral
            os_log("CBManager is powered on")
            //retrievePeripheral()
        case .poweredOff:
            os_log("CBManager is not powered on")
            // In a real app, you'd deal with all the states accordingly
            return
        case .resetting:
            os_log("CBManager is resetting")
            // In a real app, you'd deal with all the states accordingly
            return
        case .unauthorized:
            // In a real app, you'd deal with all the states accordingly
            switch central.authorization {
            case .denied:
                os_log("You are not authorized to use Bluetooth")
            case .restricted:
                os_log("Bluetooth is restricted")
            default:
                os_log("Unexpected authorization")
            }
            return
        case .unknown:
            os_log("CBManager state is unknown")
            // In a real app, you'd deal with all the states accordingly
            return
        case .unsupported:
            os_log("Bluetooth is not supported on this device")
            // In a real app, you'd deal with all the states accordingly
            return
        @unknown default:
            os_log("A previously unknown central manager state occurred")
            // In a real app, you'd deal with yet unknown cases that might occur in the future
            return
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print("didDiscover")
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("didConnect")
        
        
    }
}

// MARK: UITableViewDataSource, UITableViewDelegate Method
extension SearchBLEVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchedDeviceCell")!
        guard let convertedCell = cell as? SearchedDeviceCell else { return cell }
        
        convertedCell.delegate = self
        return convertedCell
    }
}

extension SearchBLEVC: RegistCellAction {
    
    func refresh() {
        
        deviceTableview.reloadData()
    }
    
    func goRegist() {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "GroupRegistVC") else { return }
        
        self.navigationController?.pushViewController(vc, animated: true)       
    }
    
    
}
