//
//  ContentView.swift
//  test
//
//  Created by Роман Грачик on 24.05.2023.
//

import SwiftUI

struct CarView: View {
    
    @StateObject private var viewModel = CarViewModel()
    
    var body: some View {
        
        HStack {
            VStack (alignment: .leading) {
                Text("\(viewModel.car1.name)")
                    .font(.largeTitle)
                Text("Current mileage \(viewModel.car1.currentMileage) km.")
            }
            Spacer()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CarView()
    }
}
