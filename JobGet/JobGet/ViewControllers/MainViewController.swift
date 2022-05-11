//
//  ViewController.swift
//  JobGet
//
//  Created by Deep Desai on 2022-05-09.
//

import UIKit

class MainViewController: UIViewController {

    
    let addTransactionView = AddTransactionView()
    let totalsView = TotalsView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        addConstraints()
    }
    
    private func configureViews() {
        view.backgroundColor = .white
        
        addTransactionView.translatesAutoresizingMaskIntoConstraints = false
        
        totalsView.translatesAutoresizingMaskIntoConstraints = false
        totalsView.layer.borderWidth = 2
        totalsView.layer.cornerRadius = 10
        
        view.addSubview(totalsView)
        view.addSubview(addTransactionView)
    }
    
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            addTransactionView.widthAnchor.constraint(equalToConstant: 50),
            addTransactionView.heightAnchor.constraint(equalToConstant: 50),
            addTransactionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            addTransactionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24)
        ])
        
        NSLayoutConstraint.activate([
            totalsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            totalsView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            totalsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            totalsView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }

}

