//
//  RoundedButton.swift
//  ElectricityCalculatorApp
//
//  Created by Zara on 23/01/2023.
//

import SwiftUI

struct RoundButton: View {
    var title: String
    var event: () -> Void
    
    var body: some View {
        Button(action: {
            self.event()
        }, label: {
            Text(title)
        })
        .frame(width: 250, height: 50)
        .buttonStyle(.bordered)
        .cornerRadius(13)
        .foregroundColor(.blue)
    }
}
