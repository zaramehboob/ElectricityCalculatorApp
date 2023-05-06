//
//  CalculatorView.swift
//  ElectricityCalculatorApp
//
//  Created by Zara on 23/01/2023.
//

import SwiftUI

struct CalculatorView<T>: View where T: CalculatorViewModelType {
   
    @StateObject var viewModel: T
    var container: CalculatorContainer
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            NavigationView {
                
                VStack(alignment: .center, spacing: 20) {
                
                    Text("Cost Calculator")
                        .font(.title)
                        .padding(.bottom, 50)
                        
                    
                    RoundTextFied(customerId: $viewModel.customerId, error:  $viewModel.customerError, placeHolder: "Enter Customer Serial Number")
                    RoundTextFied(customerId: $viewModel.units, error:  $viewModel.unitsError, placeHolder: "Enter electricity units")
                        .keyboardType(.numberPad)
                    
                    RoundButton(title: "Submit") {
                        viewModel.submit(completion: {})
                        hideKeyboard()
                    }
                    
                    NavigationLink(destination: NavigationLazyView( container.makeCustomerView(units: Int64(viewModel.units) ?? 0, serialNum: viewModel.customerId, customer: viewModel.customer)), isActive: $viewModel.isNextEnable, label: { EmptyView()})
                       
                }.frame(minWidth: 200, maxWidth: 350)
                    .navigationViewStyle(.stack)
                    .navigationBarHidden(true)
                
            }.onAppear {
                presentationMode.wrappedValue.dismiss()
            }
        }.alert(isPresented: $viewModel.failureValue.0, content: {
            Alert(title: Text(viewModel.failureValue.1) )
        })
        
    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView(viewModel: CalculatorViewModel(useCase: CustomerFetchUseCase(repository: CustomerRepository(service: CustomerCoreDataService(service: CoreDataService()) ))), container: CalculatorContainer())
    }
}
