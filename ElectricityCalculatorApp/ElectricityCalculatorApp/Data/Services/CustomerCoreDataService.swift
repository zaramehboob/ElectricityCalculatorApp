//
//  CustomerCoreDataService.swift
//  ElectricityCalculatorApp
//
//  Created by Zara on 23/01/2023.
//

import Foundation
import CoreData

enum CoreDataStorageError: Error {
    case readError(Error)
    case saveError(Error)
}

protocol CustomerCoreDataServiceType {
    
    func fetch(id: String, completion: @escaping (Result<CustomerDTO?, Error>) -> Void)
    func updateCustomer(id: String, units: Int64, cost: Int64, completion: @escaping (Result<Bool, Error>) -> Void)
    func addCustomer(id: String, units: Int64, cost: Int64, completion: @escaping (Result<Bool, Error>) -> Void)
}

class CustomerCoreDataService: CustomerCoreDataServiceType {
    
    private var service: CoreDataServiceType
    
    init(service: CoreDataServiceType) {
        self.service = service
    }
    
    func fetch(id: String, completion: @escaping (Result<CustomerDTO?, Error>) -> Void)  {
        
        service.performBackgroundTask { context in
            
            let request: NSFetchRequest<Customer> = Customer
                .fetchRequest()
            
            request.predicate = NSPredicate(format: "id == %@", "\(id)")
            
            do {
                let result = try self.service.workingContext.fetch(request) 
                guard let result = result.first else {
                    return   completion(.success(nil
                                                ))}
                completion(.success(result.toDomain() ))
            } catch {
                completion(.failure(CoreDataStorageError.readError(error)))
                print("Error while fetching working context: \(error)")
            }
            
        }
    }
    
    func updateCustomer(id: String, units: Int64, cost: Int64, completion: @escaping (Result<Bool, Error>) -> Void) {
        service.performBackgroundTask { [weak self] context in
            guard let self = self else {  //completion(.failure(CoreDataStorageError.saveError(Error))
                return
            }
            let request: NSFetchRequest<Customer> = Customer
                .fetchRequest()
            
            request.predicate = NSPredicate(format: "id == %@", "\(id)")
            
            do {
                let result = try context.fetch(request)
                
                let billEntity = Bill(entity: Bill.entity(), insertInto: context)
                billEntity.units = units
                billEntity.cost = cost
                var bills = result.first?.bills?.allObjects
                bills?.append(billEntity)
                result.first?.bills = NSSet(array: bills ?? [])
                result.first?.id = id
                
                _ = self.service.saveWorkingContext(context: context)
                completion(.success(true))
            } catch {
                completion(.failure(CoreDataStorageError.saveError(error)))
                print("Error while fetching working context: \(error)")
            }
            
        }
    }
    
    func addCustomer(id: String, units: Int64, cost: Int64, completion: @escaping (Result<Bool, Error>) -> Void) {
        let context = service.workingContext
        let customerEntity = Customer(entity: Customer.entity(), insertInto: context)
        customerEntity.id = id
        
        let billEntity = Bill(entity: Bill.entity(), insertInto: context)
        billEntity.units = units
        billEntity.cost = cost
        
        customerEntity.bills = NSSet(array: [billEntity])
          
        _ = self.service.saveWorkingContext(context: context)
        completion(.success(true))
       
    }
}

