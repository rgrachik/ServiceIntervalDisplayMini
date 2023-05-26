//
//  AddItemView.swift
//  test
//
//  Created by Роман Грачик on 24.05.2023.
//

import SwiftUI

struct AddParameterView: View {
    @ObservedObject var viewModel: ContentViewModel
    @State private var name = ""
    @State private var startMileage = ""
    @State private var interval = ""
    
    var body: some View {
        VStack {
            TextField("Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Start Mileage", text: $startMileage)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Interval", text: $interval)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Add") {
                let newParameter = Parameter(car: Car(), type: name,
                                             startMileage: Int(startMileage) ?? 0,
                                             interval: Int(interval) ?? 0)
                viewModel.addItem(parameter: newParameter)
            }
        }
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddParameterView(viewModel: ContentViewModel())
    }
}
