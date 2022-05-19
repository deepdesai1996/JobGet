//
//  ValidationChecker.swift
//  JobGet
//
//  Created by Deep Desai on 2022-05-17.
//

import Foundation

class ValidationChecker {
    
    func getValidationMessage(transactionType: Bool?, transactionDescription: String, transactionValue: Double) -> String {
       var message: String = ""
       
       if transactionType == nil {
           message += "Please select an appropriate transactionType."
       } else if transactionDescription.isEmpty {
           message += "Please enter a description."
       } else if transactionValue <= 0 {
           message += "please enter a value greater than 0."
       }

       return message
    }
    
}
