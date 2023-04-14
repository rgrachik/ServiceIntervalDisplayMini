//
//  main.swift
//  jjj
//
//  Created by Роман Грачик on 13.04.2023.
//

import SwiftUI

struct mainView: View {
    
    @State var selectedInterval = UserDefaults.standard.string(forKey: "selectedInterval") ?? "7500"
    @State var presentAlert = false
    @State var currentMil: String = UserDefaults.standard.string(forKey: "currentMil") ?? "\(11000)"
    @State var startMil: String = UserDefaults.standard.string(forKey: "startMil") ?? "\(10000)"
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
                    Text("\((Int(startMil)!+Int(selectedInterval)!) - Int(currentMil)!) km")
                }
                .padding()
                
                NavigationLink(destination: ChangeView(selectedInterval: $selectedInterval, presentAlert: $presentAlert, startMil: $startMil, newStartMil: $newStartMil), label: {Text("Service")})
                
                Button("Update mil") {
                    presentAlert = true
                }
                .padding()
                .alert("Current Mileage", isPresented: $presentAlert, actions: {
                    TextField("Current mileage", text: $newCurrentMil)
                        .keyboardType(.numberPad)
                    Button("OK", action: {currentMil = newCurrentMil})
                    Button("Cancel", role: .cancel, action: {newCurrentMil = currentMil})
                }, message: {
                    Text("Type your current mileage here")
                })
            }
            .onDisappear {
                UserDefaults.standard.set(selectedInterval, forKey: "selectedInterval")
                UserDefaults.standard.set(currentMil, forKey: "currentMil")
                UserDefaults.standard.set(startMil, forKey: "startMil")
            }
        }
    }
}

struct main_Previews: PreviewProvider {
    static var previews: some View {
        mainView()
    }
}
