//
//  ContentView.swift
//  test
//
//  Created by Роман Грачик on 24.05.2023.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = ContentViewModel()
    @State private var newMileage = ""
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.parameters, id: \.type) { parameter in
                        NavigationLink(destination: ParameterDetailView(parameter: parameter)) {
                            Text(parameter.type)
                            Text("\(parameter.remainingResource)")
                            Gauge(value: parameter.remainingResource, label: {})
                        }
                    }
                    .onDelete { indexSet in
                        viewModel.removeParameters(at: indexSet)
                    }
                }
                .listStyle(.sidebar)
                .navigationTitle("Service")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            viewModel.showAddModal = true
                        }) {
                            Image(systemName: "plus")
                        }
                        .sheet(isPresented: $viewModel.showAddModal) {
                            AddParameterView(viewModel: viewModel)
                        }
                    }
                    
                }
                Text("Текущий пробег: \(viewModel.parameters[0].car.currentMileage)")
                TextField("Введите новый пробег", text: $newMileage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: {
                    if let newMileageValue = Int(newMileage) {
                        viewModel.updateCurrentMileage(for: viewModel.parameters[0].car, newMileage: newMileageValue)
                        newMileage = "" // Сброс значения после обновления пробега
                    }
                }) {
                    Text("Обновить пробег")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
