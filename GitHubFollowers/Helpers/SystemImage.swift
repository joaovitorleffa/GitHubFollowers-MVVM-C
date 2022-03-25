//
//  SystemImages.swift
//  GitHubFollowers
//
//  Created by joaovitor on 25/03/22.
//

import UIKit

protocol SystemImageProtocol {
    static var starFill: UIImage? { get }
    static var gearShapeFill: UIImage? { get }
    static var moonFill: UIImage? { get }
    static var building2: UIImage? { get }
    static var location: UIImage? { get }
    static var envelope: UIImage? { get }
    static var link: UIImage? { get }
}

struct SystemImage: SystemImageProtocol {
    static private(set) var starFill = UIImage(systemName: "star.fill")
    static private(set) var gearShapeFill = UIImage(systemName: "gearshape.fill")
    static private(set) var moonFill = UIImage(systemName: "moon.fill")
    static private(set) var building2 = UIImage(systemName: "building.2")
    static private(set) var location = UIImage(systemName: "location")
    static private(set) var envelope = UIImage(systemName: "envelope")
    static private(set) var link = UIImage(systemName: "link")
}
