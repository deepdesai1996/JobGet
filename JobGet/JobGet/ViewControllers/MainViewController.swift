//
//  ViewController.swift
//  JobGet
//
//  Created by Deep Desai on 2022-05-09.
//

import Foundation
import UIKit

class MainViewController: UIViewController, DismissalDelegate {
    
    private var type: String?
    private var transactionDescription: String?
    private var value: Double = 0
    
    private let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    private var transactions = [Transaction]()
    private var dateGroups = [GroupedDate]()

    
    private let addTransactionView: AddTransactionView = {
        let addTransactionView = AddTransactionView()
        addTransactionView.translatesAutoresizingMaskIntoConstraints = false
        
        return addTransactionView
    }()
    
    private let totalsView: TotalsView = {
        let totalsView = TotalsView()
        totalsView.translatesAutoresizingMaskIntoConstraints = false
        
        return totalsView
    }()
    
    private var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.clipsToBounds = true
        table.backgroundColor = .white
        table.separatorStyle = .none
        table.layer.cornerRadius = 10
        table.sectionIndexColor = .black
        
        return table
    }() 
    
    private let transactionViewController: TransactionViewController = {
        let transactionViewController = TransactionViewController()
        transactionViewController.modalPresentationStyle = .overCurrentContext
        transactionViewController.modalTransitionStyle = .crossDissolve
        
        return transactionViewController
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        addConstraints()
        getTransactionsAndGroups()
    }
    
    @objc func addTransaction(sender: UIButton){
        transactionViewController.setParent(parentVC: self)
        present(transactionViewController, animated: true)
    }
    
    private func configureViews() {
        view.backgroundColor = .white
        
        totalsView.layer.borderWidth = 1
        totalsView.layer.cornerRadius = 10
        
        view.addSubview(totalsView)
        view.addSubview(addTransactionView)
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
        transactionViewController.dismissalDelegate = self
        
        addTransactionView.addTransactionButton.addTarget(self, action:#selector(addTransaction(sender:)), for: .touchUpInside)
    }
    
    
    private func addConstraints() {
        
        NSLayoutConstraint.activate([
            totalsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            totalsView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            totalsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            totalsView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            tableView.topAnchor.constraint(equalTo: totalsView.safeAreaLayoutGuide.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: addTransactionView.safeAreaLayoutGuide.topAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            addTransactionView.widthAnchor.constraint(equalToConstant: 50),
            addTransactionView.heightAnchor.constraint(equalToConstant: 50),
            addTransactionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -26),
            addTransactionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -26)
        ])
    }
    
    func containsDate(transactionArray: [Transaction], date: String) -> Bool {
        transactionArray.compactMap(\.itemDate).contains(date)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dateGroups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  FinancialsTableViewCell()
        cell.selectionStyle = .none
    
        var cellTransactions = [Transaction]()
        
        for item in transactions {
            if dateGroups[indexPath.row].date == item.itemDate {
                cellTransactions.append(item)
            }
        }
        
        cell.addData(transactions: cellTransactions)
        return cell
    }
    
}

extension MainViewController {

    //Core Date Functions
    
    internal func getTransactionsAndGroups() {
        guard let newContext = context else { return }
        
        do {
            transactions = try newContext.fetch(Transaction.fetchRequest())
            dateGroups = try newContext.fetch(GroupedDate.fetchRequest())
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        } catch {
            print("Unable to fetch transactions and/or group dates: \(error).")
        }
        
    }
    
    private func deleteTransaction(item: Transaction) {
        
        guard let newContext = context else { return }
        newContext.delete(item)
        
        do {
            try newContext.save()
        } catch {
            print("Unable to delete specified item: \(error)")
        }
    }
    
    func dismissal() {
        
        
        
    }
}
