//
//  JobGetTests.swift
//  JobGetTests
//
//  Created by Deep Desai on 2022-05-09.
//

import XCTest
@testable import JobGet

class JobGetTests: XCTestCase {
    
    let financer: Financer = Financer()
    
    private let transactions = [Transaction]()
    
    let validator = ValidationChecker()

    
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
    

}
