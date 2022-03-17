//
//  CellSize.swift
//  GitHubFollowers
//
//  Created by joaovitor on 17/03/22.
//

import UIKit

struct CellSize {
    static func getSize(for numOfCells: CGFloat,
                        interSpacing: CGFloat,
                        insets: UIEdgeInsets,
                        collectionViewWidth: CGFloat) -> CGSize {
        let marginAndInsets = insets.left + insets.right + interSpacing * (numOfCells - 1)
        let width = ((collectionViewWidth - marginAndInsets) / numOfCells).rounded(.down)
        let height = width * 1.25
        return CGSize(width: width, height: height)
    }
}
