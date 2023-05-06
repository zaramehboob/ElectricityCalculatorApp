//
//  Bill+CoreDataProperties.swift
//  ElectricityCalculatorApp
//
//  Created by Zara on 23/01/2023.
//
//

import Foundation
import CoreData


extension Bill {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Bill> {
        return NSFetchRequest<Bill>(entityName: "Bill")
    }

    @NSManaged public var cost: Int64
    @NSManaged public var units: Int64
    @NSManaged public var date: Date?

}

extension Bill : Identifiable {

}
