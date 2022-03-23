//
//  UIViewController+UserInterfaceStyleObserver.swift
//  GitHubFollowers
//
//  Created by joaovitor on 23/03/22.
//

import UIKit

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
