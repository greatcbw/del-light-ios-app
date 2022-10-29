//
//  DeviceGroupManageVC.swift
//  DEL Lite
//
//  Created by 강동영 on 2022/10/17.
//

import UIKit

class DeviceGroupManageVC: UIViewController {
    enum LightList: CaseIterable {
        case normal
        case mood
        case stand
        case wallLamp
        case etc
        
        var title: String {
            switch self {
            case .normal:
                return "light_normal".localized
            case .mood:
                return "light_mood".localized
            case .stand:
                return "light_stand".localized
            case .wallLamp:
                return "light_wallLamp".localized
            case .etc:
                return "light_etc".localized
            }
        }
        
        var image: UIImage {
            switch self {
            case .normal:
                return UIImage(systemName: "lightbulb")!
            case .mood:
                return UIImage(systemName: "sun.max.circle")!
            case .stand:
                return UIImage(systemName: "lamp.desk")!
            case .wallLamp:
                return UIImage(systemName: "lamp.floor")!
            case .etc:
                return UIImage(systemName: "smiley")!
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
