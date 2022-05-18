//
//  FinancialDetailsTableViewController.swift
//  JobGet
//
//  Created by Deep Desai on 2022-05-17.
//

import UIKit

class FinancialViewController: UIViewController {
    
    private var type: String?
    private var transactionDescription: String?
    private var value: Double  = 0
    private var transactions = [Transaction]()
    private let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    internal var parentVC: MainViewController?
    private var dateGroup: GroupedDate?
    
    internal let tableView: ContentSizedTableView = {
        let tableView = ContentSizedTableView()
        
        tableView.layer.cornerRadius = 10
        tableView.layer.borderWidth = 1
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        configureConstraints()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    internal func addData(transactions: [Transaction], parentVC: MainViewController, dateGroup: GroupedDate) {
        self.transactions = transactions
        self.parentVC = parentVC
        self.dateGroup = dateGroup
    }
}

extension FinancialViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = FinancialDetailTableViewCell()
        cell.layer.borderWidth = 0.5
        
        if !transactions.isEmpty {
            cell.titleLabel.text = self.transactions[indexPath.row].itemDescription
            
            if self.transactions[indexPath.row].itemValue < 0 {
                cell.secondaryLabel.text = "- $" + String(format: "%.2f", abs(self.transactions[indexPath.row].itemValue))
            } else {
                cell.secondaryLabel.text = "$" + String(format: "%.2f", self.transactions[indexPath.row].itemValue)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .black
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5),
        ])
        
        if !transactions.isEmpty {
            label.text = transactions[section].itemDate
        }
        
        
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        let sheet = UIAlertController(title: "Delete Transaction", message: "Are you sure you would like to delete this transaction?",
                                      preferredStyle: .actionSheet)
        
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        sheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
            
            guard let transaction = self?.transactions[indexPath.row] else { return }
            guard let date = self?.dateGroup else { return }
            self?.deleteTransaction(transaction: transaction, dateGroup: date)
            
            self?.parentVC?.getTransactionsAndGroups()
            self?.parentVC?.applyTotals()
            self?.parentVC?.reloadInputViews()
        }))
        
        parentVC?.present(sheet, animated: true)
        
    }
    
    private func deleteTransaction(transaction: Transaction, dateGroup: GroupedDate) {
        
        context?.delete(transaction)
        
        do {
            try context?.save()
        } catch {
            print("Unable to Delete Transaction: \(error)")
        }
        
        let result = transactions.filter { $0.itemDate == dateGroup.date}
        
        if result.isEmpty {
            context?.delete(dateGroup)
            
            do {
                try context?.save()
            } catch {
                print("Unable to Delete Transaction: \(error)")
            }
        }
    }
    
}
