//
//  ViewController.swift
//  JobGet
//
//  Created by Deep Desai on 2022-05-09.
//

import Foundation
import UIKit

class MainViewController: UIViewController, DismissalDelegate {
    
    //Transactions (stores transactions added by user)
    private var transactions = [Transaction]()
    // date Groups (determines how many days, used to oder the list
    internal var dateGroups = [GroupedDate]()
    
    //financer class which is used to create/delete/calculate transactions
    private var financer = Financer()
    
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
    
    // First table view, segmants sections of days
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
    
    // TransactionView controller, where user adds transactions
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
        updateTransactionsAndGroups()
        
        applyTotals()
    }
    
    // transaction floater button
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
    
    // number of sections is based on number of days
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dateGroups.count
    }
    
    // Financial VC is used as cell which is the detail of each transaction based on each day
    // Multiple days can have multiple transactions
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
    
    // Delegate is triggered because the transactions view is displayed modally,
    // so when it comes back to this view it does not trigger the viewDidAppear or viewWillAppear
    // this function is important to update the views
    func dismissal() {
        tableView.reloadData()
        applyTotals()
        updateTransactionsAndGroups()
    }
    
    // Adds totals to the totals view
    func applyTotals() {
        let expenseTot = financer.calculateExpenses(transactions: transactions)
        let incomeTot = financer.calculateIncome(transactions: transactions)
        let balanceTot = financer.calculateBalance(transactions: transactions)
        
        let expenseAbsoluteNumber = abs(expenseTot)
        
        let barProgress = balanceTot / incomeTot
        
        totalsView.expensesTotal.text = "$" + String(format: "%.2f", expenseAbsoluteNumber)
        totalsView.incomeTotal.text = "$" + String(format: "%.2f", incomeTot)
        totalsView.balanceTotal.text = "$" + String(format: "%.2f", balanceTot)
        
        if barProgress < 0 {
            totalsView.balanceProgressBar.setProgress(0, animated: true)
        }
        
        if barProgress.isNaN {
            totalsView.balanceProgressBar.setProgress(0, animated: true)
        } else {
            totalsView.balanceProgressBar.setProgress(Float(barProgress), animated: true)
        }
    }
    
    // Used in multiple VCs to update the array of objects
    func updateTransactionsAndGroups() {
        guard let updatedTransactions = financer.getTransactions(transactions: self.transactions, tableView: self.tableView) else { return }
        guard let updatedDateGroups = financer.getDateGroups(groupDate: self.dateGroups, tableView: self.tableView) else { return }
        self.transactions = updatedTransactions
        self.dateGroups = updatedDateGroups
    }
}
