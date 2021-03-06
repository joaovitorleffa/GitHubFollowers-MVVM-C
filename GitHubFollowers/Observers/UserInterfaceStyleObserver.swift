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

extension UIViewController: UserInterfaceStyleObserver {
    func startObserving(_ userInterfaceStyleManager: inout UserInterfaceStyleManager) {
        // Adiciona o view controller como um observer de UserInterfaceStyleManager
        userInterfaceStyleManager.addObserver(self)
        
        // Altera o view controller para o estilo desejado ao começar a "observar"
        overrideUserInterfaceStyle = userInterfaceStyleManager.currentStyle
    }
    
    func userInterfaceStyleManager(_ manager: UserInterfaceStyleManager, didChangeStyle style: UIUserInterfaceStyle) {
        // Define o estilo da UI do UIViewController
        overrideUserInterfaceStyle = style
        // Atualiza o estilo da status bar
        setNeedsStatusBarAppearanceUpdate()
    }
}

extension UIView: UserInterfaceStyleObserver {
    func startObserving(_ userInterfaceStyleManager: inout UserInterfaceStyleManager) {
        userInterfaceStyleManager.addObserver(self)
        overrideUserInterfaceStyle = userInterfaceStyleManager.currentStyle
    }
    
    func userInterfaceStyleManager(_ manager: UserInterfaceStyleManager, didChangeStyle style: UIUserInterfaceStyle) {
        overrideUserInterfaceStyle = style
    }
}

class UIThemedView: UIView {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        startObserving(&UserInterfaceStyleManager.shared)
    }
}
