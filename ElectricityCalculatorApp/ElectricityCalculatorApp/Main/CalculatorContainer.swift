//
//  CalculatorContainer.swift
//  ElectricityCalculatorApp
//
//  Created by Zara on 23/01/2023.
//

import Foundation

final class CalculatorContainer {
    
    
    init() {}
    
    private lazy var coreDataService: CoreDataServiceType =  {
        return CoreDataService()
    }()
    private lazy var customerCoreDataService: CustomerCoreDataServiceType =  {
        return CustomerCoreDataService(service: coreDataService)
    }()
    private lazy var customerRepo: CustomerRepositoryType =  {
        return CustomerRepository(service: customerCoreDataService)
    }()
    
    
    func makeCalculatorView() -> CalculatorView<CalculatorViewModel> {
        return CalculatorView(viewModel: CalculatorViewModel(useCase: CustomerFetchUseCase(repository: self.customerRepo)), container: self)
        
    }
    
    func makeCustomerView(units: Int64, serialNum: String, customer: CustomerDTO?) -> CustomerView<CustomerViewModel> {
        return CustomerView(vm: CustomerViewModel(inputUnits: units, serviceNumber: serialNum, customer: customer, calulator: Calculator(slabProvider: SlabProvider()), updateUseCase: UpdateCustomerUseCase(repository: self.customerRepo)), container: self)
    }
}
