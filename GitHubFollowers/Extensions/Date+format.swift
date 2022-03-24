//
//  Date+format.swift
//  GitHubFollowers
//
//  Created by joaovitor on 24/03/22.
//

import Foundation

extension Date {
    var format: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return dateFormatter.string(from: self)
    }
}
