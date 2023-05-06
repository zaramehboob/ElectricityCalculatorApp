//
//  UpdateBillsUseCase.swift
//  ElectricityCalculatorApp
//
//  Created by Zara on 23/01/2023.
//

import Foundation


protocol UpdateCustomerUseCaseType {
    func update(with id: String, bill: BillDTO, completion: @escaping (Result<Bool, Error>) -> Void)
    func add(customer: CustomerDTO, completion: @escaping (Result<Bool, Error>) -> Void)
}

class UpdateCustomerUseCase: UpdateCustomerUseCaseType {
    
    private var repository: CustomerRepositoryType
    init(repository: CustomerRepositoryType) {
        self.repository = repository
    }
    
    func update(with id: String, bill: BillDTO, completion: @escaping (Result<Bool, Error>) -> Void ) {
        repository.updateCustomer(id: id, bill: bill) { (result: Result<Bool, Error>) in
            completion(result)
        }
    }
    
    func add(customer: CustomerDTO, completion: @escaping (Result<Bool, Error>) -> Void ) {
        repository.addCustomer(customer: customer) { (result: Result<Bool, Error>) in
            completion(result)
        }
    }
}
