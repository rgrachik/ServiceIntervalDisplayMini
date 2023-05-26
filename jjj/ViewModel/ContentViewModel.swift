//
//  ContentViewModel.swift
//  jjj
//
//  Created by Роман Грачик on 24.05.2023.
//

import Foundation

class ContentViewModel: ObservableObject {
    @Published var parameters = [Parameter(car: Car(), type: "Motor Oil", startMileage: 5000, interval: 10000)]
    @Published var showAddModal = false
    @Published var showEditModal = false

    func addItem(parameter: Parameter) {
        parameters.append(parameter)
        showAddModal = false
    }

    func removeItem() {
        if !parameters.isEmpty {
            parameters.removeLast()
        }
    }
    
    func removeParameters(at indices: IndexSet) {
        parameters.remove(atOffsets: indices)
    }
    
   
    
    func calculateRemainingResource(for parameter: Parameter) -> Double {
        return parameter.remainingResource
    }
    
    func updateCurrentMileage(for car: Car, newMileage: Int) {
           car.currentMileage = newMileage
       }
}

