//
//  View+Extensions.swift
//  JobGet
//
//  Created by Deep Desai on 2022-05-10.
//

import Foundation
import UIKit

// Extension to pin view to top, bottom, leading, and trailing anchors
extension UIView {
    func pinToSuperView(superView: UIView) {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: superView.topAnchor),
            self.bottomAnchor.constraint(equalTo: superView.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: superView.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: superView.trailingAnchor)
        ])
    }
    
}
