//
//  main.swift
//  jjj
//
//  Created by Роман Грачик on 13.04.2023.
//

import SwiftUI

struct mainView: View {
    
    @State var selectedInterval = "7500"
    @State var presentAlert = false
    @State var currentMil: String = "\(11000)"
    @State var startMil: String = "\(10000)"
    @State var newCurrentMil: String = "\(0)"
    @State var newStartMil: String = "\(0)"
    
    var body: some View {
        NavigationStack{
            
            VStack {
                Gauge(value: Double(currentMil)! , in: Double(startMil)!...Double(startMil)!+Double(selectedInterval)!) {
                    Text("Oil")
                }
                .gaugeStyle(.accessoryCircularCapacity)
                .tint(.cyan)
                .padding()
                
                HStack{
                    Text("Service in")
                    Text("\(selectedInterval)")
                }
                .padding()
                
                NavigationLink(destination: ChangeView(selectedInterval: $selectedInterval, presentAlert: $presentAlert, startMil: $startMil, newStartMil: $newStartMil), label: {Text("Service")})
                
                Button("Update mil") {
                    presentAlert = true
                }
                .padding()
                .alert("Current Mil", isPresented: $presentAlert, actions: {
                    TextField("Current mileage", text: $newCurrentMil)
                        .keyboardType(.decimalPad)
                    Button("OK", action: {currentMil = newCurrentMil})
                    Button("Cancel", role: .cancel, action: {currentMil = "\(10000)"})
                }, message: {
                    Text("Type your current mileage here")
                })
                
            }
            
            
            
        }
    }
}

struct main_Previews: PreviewProvider {
    static var previews: some View {
        mainView()
    }
}
