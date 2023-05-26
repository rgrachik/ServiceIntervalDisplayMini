//
//  ParameterView.swift
//  jjj
//
//  Created by Роман Грачик on 24.05.2023.
//

import Foundation

struct Parameter {
    let car: Car
    let type: String
    let startMileage: Int
    let interval: Int
    
    var wear: Int {
        return max(0, car.currentMileage - startMileage)
    }
    
    var remainingResource: Double {
            let remaining = max(0, interval - wear)
            return Double(remaining) / Double(interval)
        }
}
