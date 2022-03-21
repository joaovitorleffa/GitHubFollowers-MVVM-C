//
//  Int+Format.swift
//  GitHubFollowers
//
//  Created by joaovitor on 21/03/22.
//

import Foundation

extension Int {
    var abbreviation: String {
        let number = Double(self)
        let thousand = number / 1_000
        let million = number / 1_000_000
        
        if million > 1.0 {
            return "\(round(million * 10) / 10)M"
        }
        
        if thousand > 1.0 {
            return "\(round(thousand * 10) / 10)K"
        }
        
        return "\(self)"
    }
}
