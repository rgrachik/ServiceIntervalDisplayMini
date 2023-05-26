//
//  ContentView.swift
//  test
//
//  Created by Роман Грачик on 24.05.2023.
//

import SwiftUI

struct MainView: View {
    @ObservedObject private var viewModel = ContentViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.car.parameters, id: \.type) { parameter in
                        NavigationLink(destination: ParameterDetailView(parameter: parameter, car: $viewModel.car)) { // Оберните viewModel.car в Binding
                            Text(parameter.type)
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
