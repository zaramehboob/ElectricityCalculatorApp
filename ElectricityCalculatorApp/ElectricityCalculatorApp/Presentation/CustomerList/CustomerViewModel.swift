//
//  CustomerViewModel.swift
//  ElectricityCalculatorApp
//
//  Created by Zara on 23/01/2023.
//

import Foundation

protocol CustomerViewModelType: ObservableObject {
    var customer: CustomerDTO? { get }
    var billList: [BillDTO]? { get }
    var totalCost: Int64 { get }
    var currentUnits: Int64 { get }
    var serviceNumber: String { get }
    var back: Bool { get }
    var counter: Int { get }
    func save()
}

class CustomerViewModel: CustomerViewModelType {
    
    @Published var totalCost: Int64 = 0
    @Published var customer: CustomerDTO?
    @Published var back: Bool = false
    @Published var billList: [BillDTO]?
    private var calulator: CalculatorType
    private var inputUnits: Int64
    private var updateUseCase: UpdateCustomerUseCaseType
    var serviceNumber: String
    var currentUnits: Int64 = 0
    var counter: Int = 0
    
    init(inputUnits: Int64, serviceNumber: String, customer: CustomerDTO? = nil, calulator: CalculatorType, updateUseCase: UpdateCustomerUseCaseType) {
        self.customer = customer
        self.calulator = calulator
        self.inputUnits = inputUnits
        self.serviceNumber = serviceNumber
        self.updateUseCase = updateUseCase
        self.currentUnits = inputUnits
        calculateCurrentUnits()
        sortBills()
    }
    
    func save() {
        guard (customer != nil) else {
            addCustomer()
            return
        }
        updateCustomer()
    }
    
}

private extension CustomerViewModel {
    func calculateCurrentUnits() {
        if let customer = customer {
            let total = customer.bills.map { $0.units }.reduce(0, +)
            currentUnits = inputUnits - total
        }
        totalCost = calulator.calculateCost(with: currentUnits)
    }
    
    func sortBills() {
        guard let customer = customer else { return }
        let sortedBills = customer.bills.sorted { $0.date > $1.date }
        var list = [BillDTO]()
        for i in 0..<3 {
            if i < sortedBills.count {
                list.append(sortedBills[i])
            }
        }
        billList = list
        
    }
    
    func addCustomer() {
        var customer = CustomerDTO(id: serviceNumber, bills: [BillDTO(units: inputUnits, cost: totalCost, date: Date())])
        customer.bills = [BillDTO(units: inputUnits, cost: totalCost, date: Date())]
        self.updateUseCase.add(customer: customer) { [unowned self] (result: Result<Bool , Error>) in
            switch  result {
                case .success(_):
                    self.back = true
                case .failure(let failure):
                    print("failure\(failure)")
            }
        }
    }
    
    func updateCustomer() {
        let billDTO = BillDTO(units: currentUnits, cost: totalCost, date: Date())
        guard let customer = customer else { return }
        self.updateUseCase.update(with: customer.id, bill: billDTO) { [unowned self] (result: Result<Bool , Error>) in
            switch  result {
                case .success(_):
                    DispatchQueue.main.async { [unowned self] in
                        self.back = true
                    }
                case .failure(let failure):
                    print("failure\(failure)")
            }
        }
    }
    
}
