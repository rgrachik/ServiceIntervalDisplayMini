//
//  CarModel.swift
//  jjj
//
//  Created by Роман Грачик on 24.05.2023.
//

import Foundation

class Car {
    var name: String
    var currentMileage: Int
    
    init(currentMileage: Int, name: String) {
        self.currentMileage = currentMileage
        self.name = name
    }
    
}
