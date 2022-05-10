//
//  View+Extensions.swift
//  JobGet
//
//  Created by Deep Desai on 2022-05-10.
//

import Foundation
import UIKit

extension UIView {
    
    func pinToSuperView(view: UIView) {
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: self.topAnchor),
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
}
