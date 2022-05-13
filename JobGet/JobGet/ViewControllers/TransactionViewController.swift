//
//  TransactionView.swift
//  JobGet
//
//  Created by Deep Desai on 2022-05-11.
//

import Foundation
import UIKit

protocol AddTransactionDelegate {
    func addTransactionInfo(type: String?, description: String?, value: Double)
}


class TransactionViewController: UIViewController {
    
    var delegate: AddTransactionDelegate?
    
    let container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        
        return view
    }()
    
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
        
        let image = UIImage(systemName: "arrowtriangle.down.square.fill")
        dropdown.tintColor = .systemGray3
        
        dropdown.setImage(image, for: .normal)
        
        dropdown.configuration = .plain()
        dropdown.configuration?.imagePlacement = .trailing
        dropdown.configuration?.imagePadding = 2
        
        return dropdown
    }()
    
    private let transactionDescription: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 5
        textField.textAlignment = .center
        textField.placeholder = "Transaction Description"
        
        return textField
    }()
    
    private let transactionValue: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderWidth = 1
        textField.textAlignment = .center
        textField.layer.cornerRadius = 5
        
        
        textField.placeholder = "$"
        return textField
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGray6
        button.setTitle("Add", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        
        return button
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        label.text = "Test"
        label.textAlignment = .left
        
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    private func configureViews() {
        
        addButton.addTarget(self, action:#selector(inputTransaction(sender:)), for: .touchUpInside)
        
        view.addSubview(container)
        container.addSubview(titleLabel)
        container.addSubview(transactionDropdown)
        container.addSubview(transactionDescription)
        container.addSubview(transactionValue)
        container.addSubview(transactionDropdown.dropView)
        container.addSubview(addButton)
        
        view.frame = UIScreen.main.bounds
        
        NSLayoutConstraint.activate([
            container.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            container.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            container.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
            container.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            container.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35)
            
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            transactionDropdown.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            transactionDropdown.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            transactionDropdown.heightAnchor.constraint(equalToConstant: 40),
            transactionDropdown.widthAnchor.constraint(equalToConstant: 210),
        ])
        
        NSLayoutConstraint.activate([
            transactionDescription.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            transactionDescription.topAnchor.constraint(equalTo: transactionDropdown.bottomAnchor, constant: 20),
            transactionDropdown.heightAnchor.constraint(equalToConstant: 40),
            transactionDropdown.widthAnchor.constraint(equalToConstant: 210),
        ])
        
        NSLayoutConstraint.activate([
            transactionDescription.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            transactionDescription.topAnchor.constraint(equalTo: transactionDropdown.bottomAnchor, constant: 20),
            transactionDescription.heightAnchor.constraint(equalToConstant: 40),
            transactionDescription.widthAnchor.constraint(equalToConstant: 210),
        ])
        
        NSLayoutConstraint.activate([
            transactionValue.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            transactionValue.topAnchor.constraint(equalTo: transactionDescription.bottomAnchor, constant: 20),
            transactionValue.heightAnchor.constraint(equalToConstant: 40),
            transactionValue.widthAnchor.constraint(equalToConstant: 210 / 2),
        ])
        
        NSLayoutConstraint.activate([
            addButton.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            addButton.topAnchor.constraint(equalTo: transactionValue.bottomAnchor, constant: 25),
            addButton.heightAnchor.constraint(equalToConstant: 40),
            addButton.widthAnchor.constraint(equalToConstant: 210 / 1.5),
        ])
        
        
        container.layer.borderWidth = 1
        
        transactionDropdown.dropView.dropDownOptions.append("Expense")
        transactionDropdown.dropView.dropDownOptions.append("Income")
    }
    
    @objc func inputTransaction(sender: UIButton){
        
        guard let tValueString = transactionValue.text else { return }
        guard let tValue = Double(tValueString) else { return }
        

        delegate?.addTransactionInfo(type: transactionDropdown.titleLabel?.text, description: transactionDescription.text, value: tValue)
        self.dismiss(animated: true)
    }
}
