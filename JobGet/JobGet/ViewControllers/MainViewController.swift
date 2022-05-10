//
//  ViewController.swift
//  JobGet
//
//  Created by Deep Desai on 2022-05-09.
//

import UIKit

class MainViewController: UIViewController {

    
    let addTransactionView = AddTransactionView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addTransactionView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(addTransactionView)
        addConstraints()
    }
    
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            addTransactionView.widthAnchor.constraint(equalToConstant: 50),
            addTransactionView.heightAnchor.constraint(equalToConstant: 50),
            addTransactionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            addTransactionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24)
        ])
    }

}

