//
//  TransactionView.swift
//  JobGet
//
//  Created by Deep Desai on 2022-05-11.
//

import Foundation
import UIKit

protocol DismissalDelegate {
    func dismissal()
}

class TransactionViewController: UIViewController, UITextFieldDelegate {
    
    private let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    private var groupedDateModels = [GroupedDate]()
    private var transactionType: Bool = true
    internal var dismissalDelegate: DismissalDelegate?
    internal var parentVC: MainViewController?
    private var initialStepperValue: Double = 0
    
    private let container: UIView = {
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
        let dropdown = DropdownButton.init()
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
        textField.layer.cornerRadius = 3
        textField.text = "0.00"
        
        return textField
    }()
    
    private let stepper: UIStepper = {
        let stepper = UIStepper()
        stepper.translatesAutoresizingMaskIntoConstraints = false
        stepper.tintColor = .black
        stepper.stepValue = 1
        stepper.minimumValue = 0
        stepper.maximumValue = 9999
        stepper.setIncrementImage(UIImage(systemName: "arrowtriangle.right.fill"), for: .normal)
        stepper.setDecrementImage(UIImage(systemName: "arrowtriangle.left.fill"), for: .normal)
        
        var newtransform = CGAffineTransform.identity
        newtransform = newtransform.rotated(by: -(.pi / 2))
        newtransform = newtransform.scaledBy(x: 0.55, y: 1.25)
        stepper.transform = newtransform
        
        return stepper
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
    
    private let dollarLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$"
        label.textAlignment = .left
        
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        getDateGroups()
    }
    
    private func configureViews() {
        
        initialStepperValue = stepper.value
        
        addButton.addTarget(self, action:#selector(inputTransaction(sender:)), for: .touchUpInside)
        stepper.addTarget(self, action: #selector(transactionValueChange(sender:)), for: .valueChanged)
        
        transactionValue.delegate = self
        transactionValue.keyboardType = .decimalPad
        
        view.addSubview(container)
        container.addSubview(titleLabel)
        container.addSubview(transactionDropdown)
        container.addSubview(transactionDescription)
        container.addSubview(transactionValue)
        container.addSubview(transactionDropdown.dropView)
        container.addSubview(stepper)
        container.addSubview(addButton)
        transactionValue.addSubview(dollarLabel)
        
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
            transactionValue.heightAnchor.constraint(equalToConstant: 50),
            transactionValue.widthAnchor.constraint(equalToConstant: 210 / 2),
        ])
        
        NSLayoutConstraint.activate([
            stepper.topAnchor.constraint(equalTo: transactionValue.topAnchor),
            stepper.bottomAnchor.constraint(equalTo: transactionValue.bottomAnchor),
            stepper.leadingAnchor.constraint(equalTo: transactionValue.trailingAnchor, constant: -18),
            
        ])
        
        NSLayoutConstraint.activate([
            dollarLabel.leadingAnchor.constraint(equalTo: transactionValue.leadingAnchor, constant: 2),
            dollarLabel.centerYAnchor.constraint(equalTo: transactionValue.centerYAnchor)
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
        guard let tDescription = transactionDescription.text else { return }
        
        if transactionDropdown.titleLabel?.text == "Expense" {
            transactionType = false
        } else if transactionDropdown.titleLabel?.text == "Income" {
            transactionType = true
        }
        
        let calendar = Calendar.current
        let date = Date()
        let dateComponents = calendar.component(.day, from: date)
        let numberFormatter = NumberFormatter()

        numberFormatter.numberStyle = .ordinal

        let day = numberFormatter.string(from: dateComponents as NSNumber)
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "MMM yyyy"

        let formattedDate = "\(day!) \(dateFormatter.string(from: date))"
        
        
        createTransaction(itemType: transactionType, itemDescription: tDescription, itemValue: tValue, itemDate: formattedDate)
        
        self.dismiss(animated: true, completion: {
            self.dismissalDelegate?.dismissal()
        })
    
    }
    
    @objc func transactionValueChange(sender: UIStepper){
        guard let transactionNumber = Double(transactionValue.text ?? "") else { return }
        
        
        if stepper.value > initialStepperValue {
            stepper.value = transactionNumber + 1
            initialStepperValue = stepper.value
        } else {
            stepper.value = transactionNumber - 1
            initialStepperValue = stepper.value
        }
      
        transactionValue.text = String(stepper.value)
    }
    
    func setParent(parentVC: MainViewController){
        self.parentVC = parentVC
    }
    
}

extension TransactionViewController {
    
    //Core Data Transactions
    
    private func getDateGroups() {
        do {
            guard let newContext = context else { return }
            groupedDateModels = try newContext.fetch(GroupedDate.fetchRequest())
            
            
        } catch {
            print("Unable to fetch GroupedDates: \(error).")
        }
        
    }
    
    func createTransaction(itemType: Bool, itemDescription: String, itemValue: Double, itemDate: String) {
        if groupedDateModels.isEmpty ||  !self.containsDate(date: itemDate) {
            addGroupDate(itemDate: itemDate)
        }
        
        addTransaction(itemType: itemType, itemDescription: itemDescription, itemValue: itemValue, itemDate: itemDate)
    }
    
    
    func addGroupDate(itemDate: String) {
      //  getDateGroups()
        
        guard let newContext = context else { return }
        let newGroupedDate = GroupedDate(context: newContext)
        
        newGroupedDate.date = itemDate
        do {
            try newContext.save()
            
        } catch {
            print("Unable to create new GroupDate: \(error)")
        }
    }
    
    func containsDate(date: String) -> Bool {
        groupedDateModels.compactMap(\.date).contains(date)
    }
    
    func addTransaction(itemType: Bool, itemDescription: String, itemValue: Double, itemDate: String){
        guard let newContext = context else { return }
        
        let newTransaction = Transaction(context: newContext)
        
        newTransaction.itemType = itemType
        newTransaction.itemDescription = itemDescription
        
        if itemType == true {
            newTransaction.itemValue = itemValue
        } else {
            newTransaction.itemValue = -itemValue
        }
        
        newTransaction.itemDate = itemDate
        
        do {
            try newContext.save()
            parentVC?.getTransactionsAndGroups()
            getDateGroups()
        } catch {
            print("Unable to create new Transaction: \(error)")
        }
    }
}
