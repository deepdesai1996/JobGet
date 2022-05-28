//
//  GroupedDate+CoreDataProperties.swift
//  JobGet
//
//  Created by Deep Desai on 2022-05-15.
//
//

import Foundation
import CoreData


extension GroupedDate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GroupedDate> {
        return NSFetchRequest<GroupedDate>(entityName: "GroupedDate")
    }

    @NSManaged public var date: String?

}

extension GroupedDate : Identifiable {

}
