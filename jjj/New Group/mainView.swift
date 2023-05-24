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
                        }
                    }
                }
                .listStyle(.sidebar)
                .navigationTitle("Service interval display")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("\(Image(systemName: "plus"))") {
                            viewModel.showAddModal = true
                        }
                        .sheet(isPresented: $viewModel.showAddModal) {
                            AddItemView(viewModel: viewModel)
                        }
                    }
                }
                
                Button("Remove Item") {
                    viewModel.removeItem()
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
