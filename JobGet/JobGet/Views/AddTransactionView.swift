//
//  MainView.swift
//  JobGet
//
//  Created by Deep Desai on 2022-05-09.
//

import Foundation
import UIKit

class AddTransactionView: UIView {
    
    let addTransactionButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1
        button.layer.cornerRadius = button.frame.size.width/2
        button.clipsToBounds = true
        
        let plusImage = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22, weight: .medium))
        
        button.setImage(plusImage, for: .normal)
        button.tintColor = .black
        button.setTitleColor(.black, for: .normal)

        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(addTransactionButton)
        
        addTransactionButton.pinToSuperView(superView: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
