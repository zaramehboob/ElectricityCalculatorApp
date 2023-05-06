//
//  Calculator.swift
//  ElectricityCalculatorApp
//
//  Created by Zara on 23/01/2023.
//

import Foundation

protocol CalculatorType {
    func calculateCost(with units: Int64) -> Int64
}

class Calculator: CalculatorType {
    private var slabs: [Slab]
    
    init(slabProvider: SlabProviderType) {
        self.slabs = slabProvider.slabs
    }
    
    func calculateCost(with units: Int64) -> Int64 {
        var cost: Int64 = 0
        var remainingUnits = units
        for (i, slab) in slabs.enumerated().reversed() {
            if remainingUnits >= slab.min && remainingUnits <= slab.max {
                if i > 0  {
                    let difference = remainingUnits - slabs[i - 1].max
                    remainingUnits = remainingUnits - difference
                    cost += difference * slab.rate
                } else {
                    cost += remainingUnits * slab.rate
                }
            }
        }
        
        return cost
    }
}
