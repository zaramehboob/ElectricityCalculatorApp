//
//  CustomerFetchUseCase.swift
//  ElectricityCalculatorApp
//
//  Created by Zara on 23/01/2023.
//

import Foundation

protocol CustomerFetchUseCaseType {
    func fetchCustomer(id: String, completion: @escaping (Result<CustomerDTO?, Error>) -> Void)
}

class CustomerFetchUseCase: CustomerFetchUseCaseType {
    
    private var repository: CustomerRepositoryType
    init(repository: CustomerRepositoryType) {
        self.repository = repository
    }
    
    func fetchCustomer(id: String, completion: @escaping (Result<CustomerDTO?, Error>) -> Void) {
        repository.fetchCustomer(id: id) {  (result: Result<CustomerDTO?, Error>) in
            completion(result)
        }
    }
}
