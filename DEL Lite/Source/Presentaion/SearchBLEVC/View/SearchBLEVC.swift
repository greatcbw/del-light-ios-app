//
//  SearchBLEVC.swift
//  DEL Lite
//
//  Created by 강동영 on 2022/09/26.
//

import UIKit
import RxSwift
import RxCocoa
import CoreBluetooth

class SearchBLEVC: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var deviceTableview: UITableView!
    @IBOutlet weak var searchAgaginButton: UIButton!
    
    private var bag = DisposeBag()
    
    // 현재 검색된 peripheralList입니다.
    var peripheralList : [(peripheral : CBPeripheral, RSSI : Float)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // scan 버튼을 눌러 기기 검색을 시작할 때마다 list를 초기화합니다.
        peripheralList = []
        // serial의 delegate를 ScanViewController로 설정합니다. serial에서 delegate의 메서드를 호출하면 이 클래스에서 정의된 메서드가 호출됩니다.
        serial.delegate = self
        // 뷰가 로드된 후 검색을 시작합니다.
        serial.startScan()
        
        configureTableView()
        bindComponent()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        serial.stopScan()
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
        
        searchAgaginButton
            .rx
            .tap
            .observe(on: MainScheduler.instance)
            .subscribe { _ in
                self.peripheralList = []
                serial.startScan()
            }.disposed(by: bag)
    }


}

// MARK: UITableViewDataSource, UITableViewDelegate Method
extension SearchBLEVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return peripheralList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchedDeviceCell")!
        guard let convertedCell = cell as? SearchedDeviceCell else { return cell }
        
        // peripheral의 이름을 cell에 나타나도록 합니다.
        let peripheralName = peripheralList[indexPath.row].peripheral.name
        let UUID = peripheralList[indexPath.row].peripheral.identifier
        let RSSI = peripheralList[indexPath.row].RSSI
        convertedCell.updatePeriphralsName(name: peripheralName, RSSI: RSSI, UUID: UUID)
        convertedCell.delegate = self
        return convertedCell
    }
}

extension SearchBLEVC: RegistCellAction {
    
    func refresh() {
        
        deviceTableview.reloadData()
    }
    
    func goRegist() {
        serial.stopScan()
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "GroupRegistVC") else { return }
        
        self.navigationController?.pushViewController(vc, animated: true)       
    }
    
    
}

extension SearchBLEVC: BluetoothSerialDelegate {
    
    //MARK: 시리얼에서 호출되는 딜리게이트 함수들
    func serialDidDiscoverPeripheral(peripheral: CBPeripheral, RSSI: NSNumber?) {
        // serial의 delegate에서 호출됩니다.
        // 이미 저장되어 있는 기기라면 return합니다.
        print(peripheralList)
        for existing in peripheralList {
            if existing.peripheral.identifier == peripheral.identifier {return}
        }
        // 신호의 세기에 따라 정렬하도록 합니다.
        let fRSSI = RSSI?.floatValue ?? 0.0
        peripheralList.append((peripheral : peripheral , RSSI : fRSSI))
        peripheralList.sort { $0.RSSI < $1.RSSI}
        // tableView를 다시 호출하여 검색된 기기가 반영되도록 합니다.
        deviceTableview.reloadData()
    }
    
    func serialDidConnectPeripheral(peripheral: CBPeripheral) {
        // serial의 delegate에서 호출됩니다.
        // 연결 성공 시 alert를 띄우고, alert 확인 시 View를 dismiss합니다.
        let connectSuccessAlert = UIAlertController(title: "블루투스 연결 성공", message: "\(peripheral.name ?? "알수없는기기")와 성공적으로 연결되었습니다.", preferredStyle: .actionSheet)
        let confirm = UIAlertAction(title: "확인", style: .default, handler: { _ in self.dismiss(animated: true, completion: nil) } )
        connectSuccessAlert.addAction(confirm)
        serial.delegate = nil
        present(connectSuccessAlert, animated: true, completion: nil)
    }
    
//    func serialDidReceiveMessage(message: String) {
//        //
//    }
}
