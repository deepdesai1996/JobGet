//
//  ViewController.swift
//  JobGet
//
//  Created by Deep Desai on 2022-05-09.
//

import Foundation
import UIKit

class MainViewController: UIViewController {
    
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
    
    private let tableView: UITableView = {
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
    }
    
    @objc func addTransaction(sender: UIButton){
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = FinancialsTableViewCell()
        cell.selectionStyle = .none
        return cell
    }
    
}
