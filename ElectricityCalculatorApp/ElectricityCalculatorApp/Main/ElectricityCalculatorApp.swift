//
//  ElectricityCalculatorApp.swift
//  ElectricityCalculatorApp
//
//  Created by Zara on 23/01/2023.
//

import SwiftUI

@main
struct ElectricityCalculatorApp: App {
    
    let container = CalculatorContainer()
    @State var isRunningTests = false
    var body: some Scene {
        WindowGroup {
            Group {
                if isRunningTests {
                    Text("Tests are running")
                } else {
                    container.makeCalculatorView()
                }
            }
        }
    }
}
