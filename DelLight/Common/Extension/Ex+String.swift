//
//  Ex+String.swift
//  DEL Lite
//
//  Created by 강동영 on 2022/10/10.
//

import Foundation

extension String {
    
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    func localized(arg: [CVarArg]) -> String {
        let result = String(format: self.localized, arguments: arg)
        return result
    }
}
