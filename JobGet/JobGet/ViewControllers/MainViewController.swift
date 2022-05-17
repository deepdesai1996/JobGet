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
    internal var dateGroups = [GroupedDate]()
    
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
    
    internal var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.clipsToBounds = true
        table.backgroundColor = .white
        table.separatorStyle = .none
        table.layer.cornerRadius = 10
        table.sectionIndexColor = .black
        table.tableFooterView?.isHidden = true
        
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
        applyTotals()
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
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dateGroups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let financialVC = FinancialViewController()
        self.addChild(financialVC)
        cell.contentView.addSubview(financialVC.view)
        
        
        financialVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        var cellTransactions = [Transaction]()
        
        if !dateGroups.isEmpty {
            for item in transactions {
                if dateGroups[indexPath.row].date == item.itemDate {
                    cellTransactions.append(item)
                }
            }
            financialVC.addData(transactions: cellTransactions, parentVC: self, dateGroup: dateGroups[indexPath.row])
        }
        
        
        financialVC.view.pinToSuperView(superView: cell.contentView)
        
        financialVC.didMove(toParent: self)
        financialVC.view.layoutIfNeeded()
        
        
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
    
    func dismissal() {
        tableView.reloadData()
        applyTotals()
        getTransactionsAndGroups()
    }
    
    func applyTotals() {
        let filteredExpenses = transactions.filter {$0.itemValue < 0}
        let filteredIncome = transactions.filter {$0.itemValue > 0}
        
        let expenseTot = filteredExpenses.reduce(0) { $0 + $1.itemValue}
        let incomeTot = filteredIncome.reduce(0) { $0 + $1.itemValue}
        let balanceTot = transactions.reduce(0) { $0 + $1.itemValue }
        
        let expenseAbsoluteNumber = abs(expenseTot)
        
        let barProgress = balanceTot / incomeTot
        
        totalsView.expensesTotal.text = String(format: "%.2f", expenseAbsoluteNumber)
        totalsView.incomeTotal.text = String(format: "%.2f", incomeTot)
        totalsView.balanceTotal.text = String(format: "%.2f", balanceTot)
        
        if barProgress.isNaN {
            totalsView.balanceProgressBar.setProgress(0, animated: true)
        } else {
            totalsView.balanceProgressBar.setProgress(Float(barProgress), animated: true)
        }
        
    }
    
    
}
