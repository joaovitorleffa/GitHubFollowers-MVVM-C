//
//  UserInterfaceStyleManager.swift
//  GitHubFollowers
//
//  Created by joaovitor on 23/03/22.
//

import Foundation
import UIKit

struct WeakStyleObserver {
    weak var observer: UserInterfaceStyleObserver?
}

struct UserInterfaceStyleManager {
    static let userInterfaceStyleDarkModeOn = "userInterfaceStyleDarkModeOn"
    
    private var observers = [ObjectIdentifier: WeakStyleObserver]()
    
    static var shared = UserInterfaceStyleManager()
    private init() {}
    
    private(set) var currentStyle: UIUserInterfaceStyle =
    UserDefaults.standard.bool(forKey: Self.userInterfaceStyleDarkModeOn) ? .dark : .light {
        didSet {
            if currentStyle != oldValue {
                styleDidChanged()
            }
        }
    }
}

extension UserInterfaceStyleManager {
    mutating func addObserver(_ observer: UserInterfaceStyleObserver) {
        let id = ObjectIdentifier(observer)
        observers[id] = WeakStyleObserver(observer: observer)
    }
    
    mutating func removeObserver(_ observer: UserInterfaceStyleObserver) {
        let id = ObjectIdentifier(observer)
        observers.removeValue(forKey: id)
    }
    
    mutating func updateUserInterfaceStyle(_ isDarkMode: Bool) {
        currentStyle = isDarkMode ? .dark : .light
    }
}

private extension UserInterfaceStyleManager {
    mutating func styleDidChanged() {
        for (id, weakObserver) in observers {
            // Limpa observers que não estão mais na memória
            guard let observer = weakObserver.observer else {
                observers.removeValue(forKey: id)
                continue
            }
            
            // Notifica o observer para acionar userInterfaceStyleManager(_:didChangeStyle:)
            observer.userInterfaceStyleManager(self, didChangeStyle: currentStyle)
        }
    }
}

protocol UserInterfaceStyleObserver: AnyObject {
    // adiciona observers à UserInterfaceManager
    func startObserving(_ userInterfaceStyleManager: inout UserInterfaceStyleManager)
    // chamado sempre que o estilo for alterado
    func userInterfaceStyleManager(_ manager: UserInterfaceStyleManager, didChangeStyle style: UIUserInterfaceStyle)
}
