//
//  Financial.swift
//  JobGet
//
//  Created by Deep Desai on 2022-05-17.
//

import Foundation
import UIKit

class Financer {
    
    // Core Data Context
    private let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    
    // Adding transaction to Core Database
    func addTransactionSuccessfully(itemType: Bool, itemDescription: String, itemValue: Double, itemDate: String) -> Bool {
        var isSuccessful = false
        
        guard let newContext = context else { return false }
        
        let newTransaction = Transaction(context: newContext)
        
        newTransaction.itemType = itemType
        newTransaction.itemDescription = itemDescription
        
        if itemType == true {
            newTransaction.itemValue = itemValue
        } else {
            newTransaction.itemValue = -itemValue
        }
        
        newTransaction.itemDate = itemDate
        
        do {
            try newContext.save()
            isSuccessful = true
        } catch {
            print("Unable to create new Transaction: \(error)")
            isSuccessful = false
        }
        
        return isSuccessful
    }
    
    
    //Adding date group
    func addGroupDate(itemDate: String) {
        
        guard let newContext = context else { return }
        let newGroupedDate = GroupedDate(context: newContext)
        
        newGroupedDate.date = itemDate
        do {
            try newContext.save()
        } catch {
            print("Unable to create new GroupDate: \(error)")
        }
    }
    
    
    // Getting transactions from persistent storage
    // Gets number of transactions + properties
    func getTransactions(transactions: [Transaction]?, tableView: UITableView) -> [Transaction]? {
        
        var models = transactions
        
        do {
            models = try context?.fetch(Transaction.fetchRequest())
            
            
            DispatchQueue.main.async {
                tableView.reloadData()
            }
            
        } catch {
            print("Unable to fetch transactions and/or group dates: \(error).")
        }
        
        return models
    }
    
    
    // getting Date Groups from Persistent storage
    // Date groups determine number of days which were added by user
    func getDateGroups(groupDate: [GroupedDate]?) -> [GroupedDate]? {
        
        var models = groupDate
        
        do {
            models = try context?.fetch(GroupedDate.fetchRequest())
            
        } catch {
            print("Unable to fetch GroupedDates: \(error).")
        }
        
        return models
    }
    
    // Getting datagroup and updating Tableview
    func getDateGroups(groupDate: [GroupedDate]?, tableView: UITableView) -> [GroupedDate]? {
        var models = groupDate
        
        do {
            models =  try context?.fetch(GroupedDate.fetchRequest())
            
            
            DispatchQueue.main.async {
                tableView.reloadData()
            }
            
        } catch {
            print("Unable to fetch transactions and/or group dates: \(error).")
        }
        
        return models
    }
    
    
    // Deleting transaction from persistent Storage
    func deleteTransaction(transaction: Transaction) -> Bool {
        var isSuccessful = false
        
        context?.delete(transaction)
        
        do {
            try context?.save()
            isSuccessful = true
        } catch {
            print("Unable to Delete Transaction: \(error)")
            isSuccessful = false
        }
        
        return isSuccessful
    }
    
    //Deleting Date Groups
    func deleteDateGroup(dateGroup: GroupedDate, dateCompared: [Transaction]) {
        if dateCompared.isEmpty {
            context?.delete(dateGroup)
            
            do {
                try context?.save()
            } catch {
                print("Unable to Delete Transaction: \(error)")
            }
        }
    }
    
    
    // Calculations within transactions which determine the totals
    
    func calculateExpenses(transactions: [Transaction]) -> Double {
        let filteredExpenses = transactions.filter {$0.itemValue < 0}
        
        return filteredExpenses.reduce(0) { $0 + $1.itemValue}
    }
    
    func calculateIncome(transactions: [Transaction]) -> Double {
        let filteredIncome = transactions.filter {$0.itemValue > 0}
        
        return filteredIncome.reduce(0) { $0 + $1.itemValue}
    }
    
    func calculateBalance(transactions: [Transaction]) -> Double {
        return transactions.reduce(0) { $0 + $1.itemValue }
    }
    
    // Date Formatting presentable for view
    func getFormatedCurrentDate(date: Date, format: String) -> String {
        let calendar = Calendar.current
        let dateComponents = calendar.component(.day, from: date)
        let numberFormatter = NumberFormatter()
        
        numberFormatter.numberStyle = .ordinal
        
        let day = numberFormatter.string(from: dateComponents as NSNumber)
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = format
        
        return "\(day!) \(dateFormatter.string(from: date))"
    }
}
