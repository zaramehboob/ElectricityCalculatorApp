//
//  CustomerView.swift
//  ElectricityCalculatorApp
//
//  Created by Zara on 23/01/2023.
//

import SwiftUI

struct CustomerView<T>: View where T: CustomerViewModelType {
    @StateObject var vm: T
    var container: CalculatorContainer
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        ZStack {
            Group {
                if !vm.back {
                    VStack {
                        
                        VStack {
                            CustomText(title:"ServiceNumber: \(vm.serviceNumber)")
                            HStack {
                                CustomText(title:"Units: \(vm.currentUnits)")
                                
                                CustomText(title:"Cost: $\(vm.totalCost)")
                            }
                        }.padding(20)
                        
                        Spacer(minLength: 24)
                        List {
                            ForEach(vm.billList ?? []) { bill in
                                HStack {
                                    Text("\(bill.units) units")
                                    Spacer()
                                    Text("$\(bill.cost)")
                                }
                            }
                        }
                        
                        RoundButton(title: "Save") {
                            vm.save()
                        }
                    }
                    
                    
                } else {
                    
                    container.makeCalculatorView()
                    
                }
            }
            
        }
        
    }
}
