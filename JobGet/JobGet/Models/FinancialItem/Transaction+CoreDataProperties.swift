//
//  FinancialItem+CoreDataProperties.swift
//  JobGet
//
//  Created by Deep Desai on 2022-05-15.
//
//

import Foundation
import CoreData


extension Transaction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Transaction> {
        return NSFetchRequest<Transaction>(entityName: "Transaction")
    }

    @NSManaged public var itemType: Bool
    @NSManaged public var itemValue: Double
    @NSManaged public var itemDescription: String?
    @NSManaged public var itemDate: String?

}

extension Transaction : Identifiable {

}
