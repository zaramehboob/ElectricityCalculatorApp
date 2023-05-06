//
//  BillDTO.swift
//  ElectricityCalculatorApp
//
//  Created by Zara on 23/01/2023.
//

import Foundation

struct BillDTO: Identifiable {
    var id = UUID()
    var units: Int64
    var cost: Int64
    var date: Date
}
