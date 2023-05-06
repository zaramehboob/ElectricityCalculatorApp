//
//  CalculatorTests.swift
//  ElectricityCalculatorAppTests
//
//  Created by Zara on 23/01/2023.
//

import XCTest
@testable import ElectricityCalculatorApp

final class MockSlabProvider: SlabProviderType {
    var slabs: [Slab] {
        return [Slab(min: 0, max: 100, rate: 5), Slab(min: 101, max: 500, rate: 8), Slab(min: 501, max: Int64.max, rate: 10)]
    }
}


final class CalculatorTests: XCTestCase {
    
    
    func test_calculateCost_totalBill_success() {
    
        let sut = Calculator(slabProvider: MockSlabProvider())
        
        //when
        let amount = sut.calculateCost(with: 510)
        
        //then
        XCTAssertEqual(amount, 3800)
    }
    
    func test_calculateCost_totalBill_failure() {

        let sut = Calculator(slabProvider: MockSlabProvider())
        //when
        let amount = sut.calculateCost(with: -510)
        //then
        XCTAssertNotEqual(amount, 3800)
    }
}
