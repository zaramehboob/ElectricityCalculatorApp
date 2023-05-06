//
//  Customer+CoreDataProperties.swift
//  ElectricityCalculatorApp
//
//  Created by Zara on 23/01/2023.
//
//

import Foundation
import CoreData


extension Customer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Customer> {
        return NSFetchRequest<Customer>(entityName: "Customer")
    }

    @NSManaged public var id: String?
    @NSManaged public var bills: NSSet?

}

// MARK: Generated accessors for bills
extension Customer {

    @objc(addBillsObject:)
    @NSManaged public func addToBills(_ value: Bill)

    @objc(removeBillsObject:)
    @NSManaged public func removeFromBills(_ value: Bill)

    @objc(addBills:)
    @NSManaged public func addToBills(_ values: NSSet)

    @objc(removeBills:)
    @NSManaged public func removeFromBills(_ values: NSSet)

}

extension Customer : Identifiable {

}
