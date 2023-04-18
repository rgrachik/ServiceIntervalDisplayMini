//
//  testView.swift
//  jjj
//
//  Created by Роман Грачик on 18.04.2023.
//

//import SwiftUI
//
//struct preView: View {
//    // Ссылка на другую View
//    @State private var showSecondView = false
//    
//    var body: some View {
//        NavigationView {
//            VStack {
//                Text("Welcome!")
//                    .font(.largeTitle)
//                    .fontWeight(.bold)
//                    .padding()
//                
//            }
//            .navigationTitle("My App")
//            .onAppear {
//                // Задержка на 1 секунду
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                    // Установка значения в true для перехода на другую View
//                    showSecondView = true
//                }
//            }
//            .fullScreenCover(isPresented: $showSecondView) {
//                // View, на которую нужно перейти
//                mainView()
//            }
//        }
//    }
//}
//
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        preView()
//    }
//}
