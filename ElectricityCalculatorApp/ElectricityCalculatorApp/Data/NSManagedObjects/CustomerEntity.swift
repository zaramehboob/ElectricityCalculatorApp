    //
    //  Customer.swift
    //  ElectricityCalculatorApp
    //
    //  Created by Zara on 23/01/2023.
    //

import Foundation


extension Customer {
    
    func toDomain() -> CustomerDTO {
        .init(id: id ?? "", bills: toDomainBills())
    }
    
    func toDomainBills() -> [BillDTO]{
        var billArray = [BillDTO]()
        for bill in bills?.allObjects as! [Bill] {
            billArray.append( BillDTO(id: UUID(), units: bill.units, cost: bill.cost, date: bill.date ?? Date()))
        }
        return billArray
    }
}
