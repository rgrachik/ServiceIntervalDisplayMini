//
//  main.swift
//  jjj
//
//  Created by Роман Грачик on 13.04.2023.
//

import SwiftUI
//import Combine

struct mainView: View {
    
    @State var selectedInterval = UserDefaults.standard.string(forKey: "selectedInterval") ?? "7500"
    @State var currentMil: String = UserDefaults.standard.string(forKey: "currentMil") ?? "\(0)"
    @State var startMil: String = UserDefaults.standard.string(forKey: "startMil") ?? "\(0)"
    @State var newCurrentMil: String = "" 
    @State var newStartMil: String = ""
    @State var topExpanded = false
    @State var topExpandedService = false
    
    var options = ["5000", "7500", "10000", "15000"]
    
    // MARK: - View
    
    var body: some View {
        VStack {
            // MARK: Gauge
            Gauge(value: Double(currentMil)! , in: Double(startMil)!...Double(startMil)!+Double(selectedInterval)!) {
                Text("\(Image(systemName: "oilcan"))")
                    .font(.system(size: 20))
                    .foregroundColor(.green)
            }
            .gaugeStyle(.accessoryCircularCapacity)
            .tint(.cyan)
            .padding()
            
            // MARK: text service
            
            HStack{
                Text("Service in")
                Text("\((Int(startMil)!+Int(selectedInterval)!) - Int(currentMil)!) km")
            }
            
            List {
                
                // MARK: 1st group
                
                DisclosureGroup(isExpanded: $topExpandedService) {
                    VStack {
                        VStack {
                            Text("Interval")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                            Picker("Service interval", selection: $selectedInterval) {
                                ForEach(options, id: \.self) {
                                    Text($0)
                                }
                            }.pickerStyle(.segmented)
                            Divider()
                        }
                        VStack{
                            Text("Current mileage")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                            
                            HStack {
                                TextField("Current Mileage ", text: $newStartMil)
                                    .keyboardType(.numberPad)
                                    .border(newStartMil.isEmpty ? .gray : ((Int(newStartMil) ?? 0 < 1) || (Int(newStartMil) ?? 0 > 999999) ? .red : .green))
                                    .textFieldStyle(.roundedBorder)
                                    .overlay(
                                        
                                        // MARK: Button in TF
                                        
                                        Button(action: {
                                            if let newStartMilInt = Int(newStartMil),
                                               let _ = Int(startMil),
                                               (newStartMilInt >= 1 && newStartMilInt <= 999999) {
                                                // если новый текущий пробег больше или равен 1,
                                                // и меньше или равен 999999, то присваиваем newCurrentMil значение currentMil
                                                startMil = newStartMil
                                                currentMil = startMil
                                                topExpandedService = false
                                                newStartMil = ""
                                            } else {
                                                // в противном случае, присваиваем newCurrentMil пустую строку
                                                newStartMil = ""
                                            }
                                        })  {
                                            Image(systemName:(((Int(newStartMil) ?? 0 < 1) || (Int(newStartMil) ?? 0 > 999999) ? "xmark.circle" : "checkmark.circle")))
                                                .foregroundColor(((Int(newStartMil) ?? 0 < 1) || (Int(newStartMil) ?? 0 > 999999) ? .red : .green))
                                        }
                                            .padding(.trailing, 8)
                                            .opacity(newStartMil.isEmpty ? 0 : 1),
                                        alignment: .trailing
                                    )
                            }
                        }
                    }
                }
            label: {
                HStack {
                    Image(systemName: "gear")
                    Text("Service")
                }
            }
                
                // MARK: 2st group
                
                DisclosureGroup(isExpanded: $topExpanded) {
                    VStack {
                        Text("Enter a new mileage value in \(currentMil)...\((Int(startMil) ?? 0) + (Int(selectedInterval) ?? 0)) km")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                            .opacity(0.8)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        TextField("Current Mileage ", text: $newCurrentMil)
                            .keyboardType(.numberPad)
                            .border(newCurrentMil.isEmpty ? .gray : ((Int(newCurrentMil) ?? 0 < Int(currentMil)!) || (Int(newCurrentMil) ?? 0 > 999999) ? .red : .green))
                            .textFieldStyle(.roundedBorder)
                        
                            .overlay(
                                
                                // MARK: Button in TF
                                
                                Button(action: {
                                    if let newCurrentMilInt = Int(newCurrentMil),
                                       let currentMilInt = Int(currentMil),
                                       (newCurrentMilInt >= currentMilInt && newCurrentMilInt <= 999999) {
                                        // если новый текущий пробег больше или равен текущему пробегу,
                                        // и меньше или равен 999999, то присваиваем newCurrentMil значение currentMil
                                        currentMil = newCurrentMil
                                        topExpanded = false
                                        newCurrentMil = ""
                                    } else {
                                        // в противном случае, присваиваем newCurrentMil пустую строку
                                        newCurrentMil = ""
                                    }
                                })  {
                                    Image(systemName:(((Int(newCurrentMil) ?? 0 < Int(currentMil)!) || (Int(newCurrentMil) ?? 0 > 999999) ? "xmark.circle" : "checkmark.circle")))
                                        .foregroundColor(((Int(newCurrentMil) ?? 0 < Int(currentMil)!) || (Int(newCurrentMil) ?? 0 > 999999) ? .red : .green))
                                }
                                    .padding(.trailing, 8)
                                    .opacity(newCurrentMil.isEmpty ? 0 : 1),
                                alignment: .trailing
                            )
                    }
                }
            label: {
                HStack {
                    Image(systemName: "arrow.2.circlepath")
                    Text("Update mileage")
                }
            }
            }
        }
        
        
        // MARK: Save in UD
        
        .onDisappear {
            UserDefaults.standard.set(selectedInterval, forKey: "selectedInterval")
            UserDefaults.standard.set(currentMil, forKey: "currentMil")
            UserDefaults.standard.set(startMil, forKey: "startMil")
        }
    }
}




struct main_Previews: PreviewProvider {
    static var previews: some View {
        mainView()
    }
}
