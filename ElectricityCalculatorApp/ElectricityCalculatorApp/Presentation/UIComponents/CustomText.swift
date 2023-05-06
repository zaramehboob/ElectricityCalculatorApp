//
//  CustomText.swift
//  ElectricityCalculatorApp
//
//  Created by Zara on 23/01/2023.
//

import SwiftUI

struct CustomText : View {
    var title: String
    
    var body: some View {
        Text(title)
            .bold().foregroundColor(.blue)
    }
}
