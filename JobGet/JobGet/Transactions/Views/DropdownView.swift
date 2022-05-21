//
//  DropdownView.swift
//  JobGet
//
//  Created by Deep Desai on 2022-05-12.
//

import Foundation
import UIKit


// The dropdown view and cells, created from scratch

class DropdownView: UIView {
    
    internal var dropDownOptions = [String]()
    internal let tableView = UITableView()
    
    var delegate: DropDownDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.addSubview(tableView)
        
        tableView.pinToSuperView(superView: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// giving number of cells and names of cells 
extension DropdownView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dropDownOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.text = dropDownOptions[indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.layer.borderWidth = 0.5
        cell.backgroundColor = .systemGray6
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.dropDownPressed(title: dropDownOptions[indexPath.row])
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}
