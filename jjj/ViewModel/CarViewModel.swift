//
//  ContentViewModel.swift
//  jjj
//
//  Created by Роман Грачик on 24.05.2023.
//

import Foundation

class CarViewModel: ObservableObject {
    
    @Published var car1 = Car(currentMileage: 100000, name: "My Car")
    
}

