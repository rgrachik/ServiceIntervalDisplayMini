//////
//////  testView.swift
//////  jjj
//////
////  Created by Роман Грачик on 13.04.2023.
////
//
//import SwiftUI
//
//struct testView: View {
//    @State private var presentAlert = false
//    @State private var username: String = ""
//    
//    var body: some View {
//        Button("Show Alert") {
//            presentAlert = true
//        }
//        .alert("Current Mil", isPresented: $presentAlert, actions: {
//            TextField("Username", text: $username)
//                .keyboardType(.numberPad)
//                .textFieldStyle(RestrictedTextFieldStyle)
//            
//            Button("OK", action: {})
//            Button("Cancel", role: .cancel, action: {username = ""})
//        }, message: {
//            Text("Type your current mileage here")
//        })
//    }
//}
//
//
//
//struct testView_Previews: PreviewProvider {
//    static var previews: some View {
//        testView()
//    }
//}
