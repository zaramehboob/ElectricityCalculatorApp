//
//  CalculatorViewModel.swift
//  ElectricityCalculatorApp
//
//  Created by Zara on 23/01/2023.
//

import SwiftUI

protocol CalculatorViewModelType: ObservableObject {
    var isNextEnable: Bool { get set}
    var units: String { get set }
    var customerId: String { get set}
    var customerError: String? { get set }
    var unitsError: String? { get set }
    var customer: CustomerDTO? { get }
    var failureValue: (Bool, String) { get set}
    func submit(completion: (() -> Void)?)
    
}

class CalculatorViewModel: CalculatorViewModelType {
    
    @Published var isNextEnable = false
    @Published var units: String  {
        didSet {
            
            unitsError = nil
        }
    }
    @Published var customerError: String?
    @Published var unitsError: String?
    @Published var customerId: String {
        didSet {

            isFetchCustomer = true
            customerError = nil
            
        }
    }
    @Published var failureValue: (Bool, String) = (false, "")
    
    private var useCase: CustomerFetchUseCaseType
    private var isFetchCustomer: Bool = false
    private var isCustomerValid: Bool = false
    
    var customer: CustomerDTO?
    
    init(useCase: CustomerFetchUseCaseType) {
        customerId = ""
        units = ""
        self.useCase = useCase
    }
    
    func fetch(completion: @escaping (CustomerDTO?) -> Void) {
        useCase.fetchCustomer(id: customerId) { [weak self] (result: Result<CustomerDTO?,Error>) in
            guard let self = self else {return}
            switch result {
                case .success(let value):
                    completion(value)
                case .failure(let failure):
                    self.failureValue = (true, failure.localizedDescription)
            }
            
        }
    }
    
    func submit(completion: (() -> Void)? = nil) {
        startValidating(completion: completion)
    }
}

private extension CalculatorViewModel {
    
    func startValidating(completion: (() -> Void)? = nil) {
        let isCustomerValid = validateServiceNumber(with: customerId)
        customerError =  isCustomerValid.0 ? nil : isCustomerValid.1
        if isFetchCustomer && isCustomerValid.0 {
            fetch { [weak self] value in
                guard let self = self else { return }
                self.customer = value
                self.isFetchCustomer = true
                self.processUnitsValidity(completion: completion)
                
            }
        }
    }
    
    func processUnitsValidity(completion: (() -> Void)? = nil) {
        
        var unitsResult = validateUnits(with: units)
        if unitsResult.0 {
            let total = customer?.bills.map { $0.units }.reduce(0, +)
            unitsResult =  validateWithPreviousUnits(with: Int64(units)!, previousUnits: total ?? 0)
        }
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.unitsError = unitsResult.0 ? nil : unitsResult.1
            self.isNextEnable = self.validateServiceNumber(with: self.customerId).0 && unitsResult.0
            completion?()
        }
            
    }
}

private extension CalculatorViewModel {
    func validateServiceNumber(with id: String) -> (Bool, String) {
        let regex = "[A-Za-z0-9]{10}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        let result = predicate.evaluate(with: id)
        return (result, "Serial number is of 10 characters")
    }
    
        //    func validateUnits() -> String? {
        //        guard !units.isEmpty else { return "Enter units" }
        //        let regex = "^[1-9][0-9]*$"
        //        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        //        let result = predicate.evaluate(with: units)
        //        let total = customer?.bills.map { $0.units }.reduce(0, +)
        //        guard Int(units)! > total ?? 0 else {
        //            return "Units should have higher value"
        //        }
        //
        //        return result ? nil : "Units have only digits"
        //    }
    
    func validateUnits(with units: String) -> (Bool, String) {
        guard !units.isEmpty else { return (false, "Enter units") }
        let regex = "^[1-9][0-9]*$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        let result = predicate.evaluate(with: units)
        
        return (result, "Enter only digits")
    }
    
    func validateWithPreviousUnits(with units: Int64, previousUnits: Int64) -> (Bool, String) {
        guard units > previousUnits else {
            return (false, "Units should have higher value")
        }
        return (true,"")
    }
    
}
