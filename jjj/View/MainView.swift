//
//  MainView.swift
//  jjj
//
//  Created by Роман Грачик on 29.05.2023.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = MainViewModel()
    @State var selectedTab: Int? = nil
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(viewModel.carViews.indices, id: \.self) { index in
                viewModel.carViews[index]
                    .tag(index)
            }
            
            HStack {
                Button(action: {
                    viewModel.addNewCarView()
                    selectedTab = viewModel.carViews.count - 1
                }) {
                    HStack {
                        Text("\(Image(systemName: "plus")) Добавить новую машину")
                    }
                    .font(.title2)
                }
            }
        }
        .tabViewStyle(.page)
        .colorMultiply(.gray)
    }
}



struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
