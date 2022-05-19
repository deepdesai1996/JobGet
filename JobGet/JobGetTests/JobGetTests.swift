//
//  JobGetTests.swift
//  JobGetTests
//
//  Created by Deep Desai on 2022-05-09.
//

import XCTest
@testable import JobGet

class JobGetTests: XCTestCase {

    /// PLEASE READ BEFORE ATTEMPTING TESTS:
    /// Please test UI Thoroughly before testing the Unit Tests, these unit tests affect the UI of the app since they directly interact with the Core Data Entities!
    /// !! These tests affect the real data for the Core data entities, run once only. If you want to run it again, Please fresh install !!
    
    
    let financer: Financer = Financer()
    let validator = ValidationChecker()
    var transactions = [Transaction]()
    let testTable = UITableView()
    
    
    func testAddTransaction() {
        //added this line because since these functions add to the data base, it affects the ui in real time (please make sure dates match for both function)
        financer.addGroupDate(itemDate: "August 15th, 2022")
        //item type = true means it is an income <> false means its an expense
        let result = financer.addTransactionSuccessfully(itemType: true, itemDescription: "Tuition", itemValue: 7200.67, itemDate: "August 15th, 2022")
        XCTAssertTrue(result)
    }
    
    //date formatting manually to compare, since the date changes everytime tested we can't use a constant date. It will need to be dynamic
    func manuallyFormatDate() -> String {
        let date = Date()
        let calendar = Calendar.current
        let dateComponents = calendar.component(.day, from: date)
        let numberFormatter = NumberFormatter()
        
        numberFormatter.numberStyle = .ordinal
        
        let day = numberFormatter.string(from: dateComponents as NSNumber)
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "MMYY"
        
        return "\(day!) \(dateFormatter.string(from: date))"
    }
    
    
    func testFormattedDate() {
        let todaysDate = financer.getFormatedCurrentDate(date: Date(), format: "MMYY")
        
        XCTAssertEqual(todaysDate, manuallyFormatDate())
    }
    
    func testValidationMessage() {
        let message = validator.getValidationMessage(transactionType: nil, transactionDescription: "Bills", transactionValue: 30)
        
        XCTAssertEqual(message, "Please select an appropriate transactionType.")
    }
    
    func testDeletedTransaction() {
       // guard let updatedGroup = financer.getDateGroups(groupDate: dateGroup) else { return }
       // dateGroup = updatedGroup
        
        guard let updatedTransactions = financer.getTransactions(transactions: transactions, tableView: testTable) else { return }
        
        transactions = updatedTransactions
        
        let result = financer.deleteTransaction(transaction: transactions[0])
        
        XCTAssertTrue(result)
    }
    
    func testCalculations () {

        financer.addTransactionSuccessfully(itemType: true, itemDescription: "Tuition", itemValue: -7000.67, itemDate: "August 15th, 2022")

        guard let updatedTransactions = financer.getTransactions(transactions: transactions, tableView: testTable) else { return }

        transactions = updatedTransactions
        let income = financer.calculateIncome(transactions: transactions)
        let expenses = financer.calculateExpenses(transactions: transactions)
        let balance =  financer.calculateBalance(transactions: transactions)

        XCTAssertEqual(income, 7200.67)
        XCTAssertEqual(expenses, -7000.67)
        XCTAssertEqual(balance, 200)

    }

}
