//
//  CustomerRepository.swift
//  ElectricityCalculatorApp
//
//  Created by Zara on 23/01/2023.
//

import Foundation

class CustomerRepository: CustomerRepositoryType {
    
    private var customerService: CustomerCoreDataServiceType
    
    init(service: CustomerCoreDataServiceType) {
        self.customerService = service
    }
    
    
    func fetchCustomer(id: String, completion: @escaping (Result<CustomerDTO?, Error>) -> Void ) {
        customerService.fetch(id: id) { (result: Result<CustomerDTO?, Error>) in
            completion(result)
        }
    }
    
    func updateCustomer(id: String, bill: BillDTO, completion: @escaping (Result<Bool, Error>) -> Void) {
        customerService.updateCustomer(id: id, units: bill.units, cost: bill.cost) { (result: Result<Bool, Error>) in
            completion(result)
        }
    }
    
    func addCustomer(customer: CustomerDTO, completion: @escaping (Result<Bool, Error>) -> Void) {
        customerService.addCustomer(id: customer.id, units: customer.bills.first?.units ?? 0, cost: customer.bills.first?.cost ?? 0) { (result: Result<Bool, Error>) in
            completion(result)
        }
    }
    
}
