//
//  ContentView.swift
//  test
//
//  Created by Роман Грачик on 24.05.2023.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.parameters, id: \.type) { parameter in
                        NavigationLink(destination: ParameterDetailView(parameter: parameter)) {
                            Text(parameter.type)
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
                
                Button(action: {
                    viewModel.showEditModal = true
                }) {
                    Image(systemName: "plus")
                }
                .sheet(isPresented: $viewModel.showEditModal) {
                    AddParameterView(viewModel: viewModel)
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
