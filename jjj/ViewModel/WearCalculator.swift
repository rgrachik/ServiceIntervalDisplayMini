//
//  WearCalculator.swift
//  jjj
//
//  Created by Роман Грачик on 26.05.2023.
//

import Foundation

struct WearCalculator {
    func calculateWear(for parameter: Parameter, currentMileage: Int) -> Double {
        let mileageDifference = Double(currentMileage - parameter.startMileage)
        let wearPercentage = mileageDifference / Double(parameter.interval)
        return wearPercentage
    }
}
