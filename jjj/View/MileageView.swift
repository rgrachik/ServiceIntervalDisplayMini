//
//  MileageView.swift
//  jjj
//
//  Created by Роман Грачик on 26.05.2023.
//

//import SwiftUI
//
//struct MileageView: View {
//    @ObservedObject var viewModel: ContentViewModel
//    @State private var newMileage: String = ""
//    
//    var body: some View {
//        VStack {
//            Text("Текущий пробег: \(viewModel.car.currentMileage)")
//            
//            TextField("Введите пробег", text: $newMileage)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//            
//            Button("Обновить пробег") {
//                if let mileage = Int(newMileage) {
//                    viewModel.updateCurrentMileage(mileage)
//                }
//                newMileage = ""
//            }
//        }
//        .padding()
//    }
//}
//
//
//struct MileageView_Previews: PreviewProvider {
//    static var previews: some View {
//        MileageView(viewModel: ContentViewModel())
//    }
//}
