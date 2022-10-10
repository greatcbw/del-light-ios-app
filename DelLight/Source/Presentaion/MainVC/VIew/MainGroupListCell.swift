//
//  MainGroupListCell.swift
//  DEL Lite
//
//  Created by 강동영 on 2022/10/11.
//

import UIKit

class MainGroupListCell: UITableViewCell {

    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var lightCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureCollectionView()
    }

    private func configureCollectionView() {
        
        lightCollectionView.dataSource = self
        lightCollectionView.delegate = self
    }

}

extension MainGroupListCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LightListCell", for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 100, height: 100)
    }
}

class LightListCell: UICollectionViewCell {
 
    @IBOutlet weak var lightButton: UIButton!
    @IBOutlet weak var lightName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("awakeFromNib")
    }
}
