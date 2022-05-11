//
//  FinancialsTableViewCell.swift
//  JobGet
//
//  Created by Deep Desai on 2022-05-11.
//

import Foundation
import UIKit

class FinancialsTableViewCell: UITableViewCell {
    
    private let tableView = ContentSizedTableView(frame: CGRect(x: 0, y: 0, width: 50, height: 50), style: .insetGrouped)

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(tableView)
        addConstraints()
        
        tableView.layer.borderWidth = 1
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
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

        
        return cell
    }
}
