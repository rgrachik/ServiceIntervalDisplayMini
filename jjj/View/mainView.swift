//
//  ContentView.swift
//  test
//
//  Created by Роман Грачик on 24.05.2023.
//

import SwiftUI

struct MainView: View {
    @ObservedObject private var viewModel = ContentViewModel()
    private let wearCalculator = WearCalculator()
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.car.parameters, id: \.type) { parameter in
                        NavigationLink(destination: ParameterDetailView(parameter: parameter, car: $viewModel.car)) {
                            HStack {
                                Text(parameter.type)
                                Text("\(viewModel.calculateWear(for: parameter), specifier: "%.1f")")
                            }
                        }
                    }
                    .onDelete { indexSet in
                        viewModel.removeParameters(at: indexSet)
                    }
                }
                .listStyle(.sidebar)
                .navigationTitle("Service interval display")
                .navigationBarTitleDisplayMode(.inline)
                
                MileageView(viewModel: viewModel)
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
            }
        }
    }
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
