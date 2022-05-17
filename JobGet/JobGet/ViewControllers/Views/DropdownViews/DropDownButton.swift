//
//  DropDownButton.swift
//  JobGet
//
//  Created by Deep Desai on 2022-05-12.
//

import Foundation
import UIKit

protocol DropDownDelegate {
    func dropDownPressed(title: String)
}

class DropdownButton: UIButton, DropDownDelegate {
    
    internal let dropView = DropdownView()
    private var height = NSLayoutConstraint()
    private var isOpen = false
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        dropView.translatesAutoresizingMaskIntoConstraints = false
        dropView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        self.superview?.addSubview(dropView)
        self.superview?.bringSubviewToFront(dropView)
        
        NSLayoutConstraint.activate([
            dropView.topAnchor.constraint(equalTo: self.bottomAnchor),
            dropView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            dropView.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
        
        height = dropView.heightAnchor.constraint(equalToConstant: 0)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isOpen == false {
            isOpen = true
            NSLayoutConstraint.deactivate([self.height])
            
            self.height.constant = self.dropView.tableView.contentSize.height
            
            NSLayoutConstraint.activate([self.height])
            
        } else {
            dismissDropDown()
        }
    }
    
    internal func dropDownPressed(title: String) {
        self.setTitle(title, for: .normal)
        dismissDropDown()
    }
    
    private func dismissDropDown() {
        isOpen = false
        
        NSLayoutConstraint.deactivate([self.height])
        self.height.constant = 0
        NSLayoutConstraint.activate([self.height])
    }
    
}
