//
//  ContentView.swift
//  jjj
//
//  Created by Роман Грачик on 13.04.2023.
//

import SwiftUI

struct ChangeView: View {
    var options = ["5000", "7500", "10000"]
    @Binding var selectedInterval: String
    @Binding var presentAlert: Bool
    @Binding var startMil: String
    @Binding var newStartMil: String
    
    var body: some View {
        NavigationView {
            List {
                HStack{
                    Text("Current mil")
                    Spacer()
                    Button("\(startMil)") {
                        presentAlert = true
                    }
                    .foregroundColor(.accentColor)
                    .alert("Current Mil", isPresented: $presentAlert, actions: {
                        TextField("currentMil", text: $newStartMil)
                            .keyboardType(.numberPad)
                        Button("OK", action: {startMil = newStartMil})
                        Button("Cancel", role: .cancel, action: {newStartMil = startMil})
                    }, message: {
                        Text("Type your current mileage here")
                    })
                    
                }
                
                Picker("Service interval", selection: $selectedInterval) {
                    ForEach(options, id: \.self) {
                        Text($0)
                    }
                }.pickerStyle(.menu)
            }
            .navigationTitle("Settings")
        }
    }
}

//struct ChangeView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChangeView()
//    }
//}
