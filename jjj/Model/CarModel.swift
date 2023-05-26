//
//  CarModel.swift
//  jjj
//
//  Created by Роман Грачик on 24.05.2023.
//

import Foundation

class Car: ObservableObject {
    @Published var currentMileage: Int = 0
    var parameters: [Parameter] = [Parameter(type: "Motor Oil", startMileage: 5000, interval: 10000)]
}

