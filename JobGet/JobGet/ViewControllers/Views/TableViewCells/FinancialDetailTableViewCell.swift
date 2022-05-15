//
//  FinancialDetailTableViewCell.swift
//  JobGet
//
//  Created by Deep Desai on 2022-05-13.
//

import UIKit

class FinancialDetailTableViewCell: UITableViewCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let secondaryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViews() {
        self.addSubview(titleLabel)
        self.addSubview(secondaryLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            //titleLabel.trailingAnchor.constraint(equalTo: secondaryLabel.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            secondaryLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            secondaryLabel.leadingAnchor.constraint(equalTo: self.centerXAnchor),
            secondaryLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
    }
}
