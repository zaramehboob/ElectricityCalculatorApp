//
//  Slabs.swift
//  ElectricityCalculatorApp
//
//  Created by Zara on 23/01/2023.
//

import Foundation

protocol SlabProviderType {
    var slabs: [Slab] { get }
}

struct SlabProvider: SlabProviderType {
    var slabs: [Slab] {
        return [Slab(min: 0, max: 100, rate: 5), Slab(min: 101, max: 500, rate: 8), Slab(min: 501, max: Int64.max, rate: 10)]
    }
}

struct Slab {
    var min: Int64
    var max: Int64
    var rate: Int64
}
