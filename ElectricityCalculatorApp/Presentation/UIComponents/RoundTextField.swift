//
//  RoundTextField.swift
//  ElectricityCalculatorApp
//
//  Created by Zara on 23/01/2023.
//

import SwiftUI

struct RoundTextFied: View {
    @Binding var customerId: String
    @Binding var error: String?
    var placeHolder: String
    
    var body: some View {
        
        TextField(placeHolder, text: $customerId)
            .modifier(TextFieldModifier(error: $error))
        
    }
    
}

struct TextFieldModifier: ViewModifier {
    @Binding var error: String?
    
    func body(content: Content) -> some View {
        content
            .padding(10)
            .frame(height: 50)
            .foregroundColor(Color.gray)
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(Color.gray, lineWidth: 2)
            )
        Text(error ?? "")
            .padding(.top, -12)
            .foregroundColor(.red)
            .font(.system(size: 12))
    }
    
    
}
