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
        label.text = "Add Transaction"
        label.textAlignment = .center
        
        return label
    }()
    
    internal var transactionDropdown: DropdownButton = {
        let dropdown = DropdownButton.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        dropdown.translatesAutoresizingMaskIntoConstraints = false
        dropdown.layer.borderWidth = 1
        dropdown.layer.cornerRadius = 5
        dropdown.setTitleColor(.black, for: .normal)
        dropdown.setTitle("Transaction Type", for: .normal)
        
        return dropdown
    }()
    
    private let container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white

        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    private func configureViews() {
        
        view.addSubview(container)
        container.addSubview(titleLabel)
        container.addSubview(transactionDropdown)
        
        view.frame = UIScreen.main.bounds
        
        NSLayoutConstraint.activate([
            container.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            container.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            container.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
            container.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            container.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.45)
            
        ])
        
        NSLayoutConstraint.activate([
            transactionDropdown.heightAnchor.constraint(equalToConstant: 50),
            transactionDropdown.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        container.layer.borderWidth = 1
        
        transactionDropdown.dropView.dropDownOptions.append("Expense")
        transactionDropdown.dropView.dropDownOptions.append("Income")
    }
    
}
