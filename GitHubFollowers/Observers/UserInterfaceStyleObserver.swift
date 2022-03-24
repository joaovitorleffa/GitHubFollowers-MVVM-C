//
//  UserInterfaceStyleObserver.swift
//  GitHubFollowers
//
//  Created by joaovitor on 24/03/22.
//

import UIKit

protocol UserInterfaceStyleObserver: AnyObject {
    // adiciona observers à UserInterfaceManager
    func startObserving(_ userInterfaceStyleManager: inout UserInterfaceStyleManager)
    // chamado sempre que o estilo for alterado
    func userInterfaceStyleManager(_ manager: UserInterfaceStyleManager, didChangeStyle style: UIUserInterfaceStyle)
}
