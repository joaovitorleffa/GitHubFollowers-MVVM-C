//
//  Date+dateFromString.swift
//  GitHubFollowers
//
//  Created by joaovitor on 22/03/22.
//

import Foundation

extension String {
    var date: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        let date = dateFormatter.date(from: self)
    
        return date!
    }
}
