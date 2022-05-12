//
//  TransactionView.swift
//  JobGet
//
//  Created by Deep Desai on 2022-05-11.
//

import Foundation
import UIKit

class TransactionViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "TEST"
        
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "TEST2"
        
        return label
    }()
    
    private let container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white

        return view
    }()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.frame = UIScreen.main.bounds
        view.addSubview(container)
        configureViews()
    }
    
    private func configureViews() {
        view.frame = UIScreen.main.bounds
        view.addSubview(container)
        
        NSLayoutConstraint.activate([
            container.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            container.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            container.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
            container.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            container.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.45)
            
        ])
        
        container.layer.borderWidth = 1
    }
    
}
