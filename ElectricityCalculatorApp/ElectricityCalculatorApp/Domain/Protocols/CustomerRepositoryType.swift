//
//  CustomerRepositoryType.swift
//  ElectricityCalculatorApp
//
//  Created by Zara on 23/01/2023.
//

import Foundation

protocol CustomerRepositoryType {
    func fetchCustomer(id: String, completion: @escaping (Result<CustomerDTO?, Error>) -> Void )
    func updateCustomer(id: String, bill: BillDTO, completion: @escaping (Result<Bool, Error>) -> Void)
    func addCustomer(customer: CustomerDTO, completion: @escaping (Result<Bool, Error>) -> Void)
}
