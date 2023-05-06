//
//  CalculatorViewModelTests.swift
//  ElectricityCalculatorAppTests
//
//  Created by Zara on 23/01/2023.
//


import XCTest
@testable import ElectricityCalculatorApp

final private class MockFetchUseCase: CustomerFetchUseCaseType {
    
    private var result: Result<CustomerDTO?, Error>
    
    init(result: Result<CustomerDTO?, Error>) {
        self.result = result
    }
    func fetchCustomer(id: String, completion: @escaping (Result<CustomerDTO?, Error>) -> Void) {
        return completion(result)
    }
    
    
}

final class CalculatorViewModelTests: XCTestCase {
    
    func test_submit_customerIdAlphaNumeric_success() {
        
        let sut = CalculatorViewModel(useCase: MockFetchUseCase(result: .success(CustomerDTO(id: "1234UJ6789", bills: [BillDTO(units: 250 , cost: 1700, date: Date())] ))) )
        
        let exp = expectation(description: "Validate User with correct customer ID")
        //when
        sut.customerId = "1234UJ6789"
        sut.units = "350"
        sut.submit {
            exp.fulfill()
        }
        
        //then
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertTrue(sut.isNextEnable)
        
    }
    
    func test_submit_customerIdAlphaNumeric_failure() {
        
        let sut = CalculatorViewModel(useCase: MockFetchUseCase(result: .success(CustomerDTO(id: "1234UJ78", bills: [BillDTO(units: 250 , cost: 1700, date: Date())] ))) )
        
            //when
        sut.customerId = "1234UJ78"
        sut.units = "350"
        sut.submit()
        
        
        //then
        XCTAssertFalse(sut.isNextEnable)
        
    }
    
    func test_submit_units_failure() {
        
        let sut = CalculatorViewModel(useCase: MockFetchUseCase(result: .success(CustomerDTO(id: "1234UJ7890", bills: [BillDTO(units: 250 , cost: 1700, date: Date())] ))) )
        let exp = expectation(description: "Validate User with incorrect units")
            //when
        sut.customerId = "1234UJ7890"
        sut.units = "-50"
        sut.submit{
            exp.fulfill()
        }
        
            //then
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertFalse(sut.isNextEnable)
        
    }
    
    func test_submit_UnitsHigherValue_thenPrevious_failure() {
        
        let sut = CalculatorViewModel(useCase: MockFetchUseCase(result: .success(CustomerDTO(id: "1234UJ7890", bills: [BillDTO(units: 250 , cost: 1700, date: Date())] ))) )
        let exp = expectation(description: "Validate User with incorrect units")
            //when
        sut.customerId = "1234UJ7890"
        sut.units = "50"
        sut.submit {
            exp.fulfill()
        }
        
            //then
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertFalse(sut.isNextEnable)
        
    }
    
    func test_submit_units_success() {
        
        let sut = CalculatorViewModel(useCase: MockFetchUseCase(result: .success(CustomerDTO(id: "1234UJ7890", bills: [BillDTO(units: 250 , cost: 1700, date: Date())] ))) )
        let exp = expectation(description: "Validate User with incorrect units")
            //when
        sut.customerId = "1234UJ7890"
        sut.units = "450"
        sut.submit{
            exp.fulfill()
        }
        
            //then
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertTrue(sut.isNextEnable)
        
    }
}
