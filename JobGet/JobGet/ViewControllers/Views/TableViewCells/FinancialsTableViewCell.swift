//
//  FinancialsTableViewCell.swift
//  JobGet
//
//  Created by Deep Desai on 2022-05-11.
//

import Foundation
import UIKit

class FinancialsTableViewCell: UITableViewCell {
    
    internal let tableView = ContentSizedTableView()
    private var type: String?
    private var transactionDescription: String?
    private var value: Double  = 0
    private var transactions = [Transaction]()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(tableView)
        addConstraints()
        
        tableView.layer.cornerRadius = 10
        tableView.layer.borderWidth = 1
        tableView.separatorStyle = .none
        
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            tableView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    internal func addData(transactions: [Transaction]){
        self.transactions = transactions
    }
    

}

extension FinancialsTableViewCell: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = FinancialDetailTableViewCell()
        
        cell.selectionStyle = .none
        cell.layer.borderWidth = 0.5
        
        cell.titleLabel.text = self.transactions[indexPath.row].itemDescription
        cell.secondaryLabel.text = String(format: "%.2f", self.transactions[indexPath.row].itemValue)

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

            label.text = transactions[section].itemDate

            return view
        }
    
}
