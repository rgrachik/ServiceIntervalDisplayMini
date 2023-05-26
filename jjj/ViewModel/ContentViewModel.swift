//
//  ContentViewModel.swift
//  jjj
//
//  Created by Роман Грачик on 24.05.2023.
//

import Foundation

class ContentViewModel: ObservableObject {
    @Published var parameters = [Parameter(type: "Motor Oil", startMileage: 0, interval: 0)]
    @Published var showAddModal = false
    @Published var showEditModal = false
    
    var car = Car()
    
    func addItem(parameter: Parameter) {
        car.parameters.append(parameter)
        showAddModal = false
    }

    
    func removeItem() {
        if !parameters.isEmpty {
            parameters.removeLast()
        }
    }
    
    func removeParameters(at indices: IndexSet) {
        car.parameters.remove(atOffsets: indices)
    }

    
    func updateCurrentMileage(_ mileage: Int) {
        car.currentMileage = mileage
    }
}


