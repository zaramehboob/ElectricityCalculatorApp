//
//  CustomerDTO.swift
//  ElectricityCalculatorApp
//
//  Created by Zara on 23/01/2023.
//

import Foundation

struct CustomerDTO: Identifiable {
    var id: String
    var bills: [BillDTO]
}
