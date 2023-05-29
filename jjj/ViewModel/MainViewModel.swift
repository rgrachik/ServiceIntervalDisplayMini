//
//  MainViewModel.swift
//  jjj
//
//  Created by Роман Грачик on 29.05.2023.
//

import Foundation
import SwiftUI

class MainViewModel: ObservableObject {
    @Published var carViews: [CarView] = []
    
    
    func addNewCarView() {
        let newCarView = CarView() // Создание нового экземпляра CarView
        carViews.append(newCarView) // Добавление в массив carViews
    }
}

