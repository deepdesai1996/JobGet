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

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(tableView)
        addConstraints()
        
        tableView.tableHeaderView?.isHidden = true
        tableView.tableFooterView?.isHidden = true
        
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
            //tableView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
}

extension FinancialsTableViewCell: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        cell.textLabel?.text = "test"
        cell.layer.borderWidth = 0.5
        
        return cell
    }
    
}
