//
//  main.swift
//  jjj
//
//  Created by Роман Грачик on 13.04.2023.
//

import SwiftUI
import Combine

struct mainView: View {
    
    @State var selectedInterval = UserDefaults.standard.string(forKey: "selectedInterval") ?? "7500"
    @State var presentAlert = false
    @State var currentMil: String = UserDefaults.standard.string(forKey: "currentMil") ?? "\(11000)"
    @State var startMil: String = UserDefaults.standard.string(forKey: "startMil") ?? "\(10000)"
    @State var newCurrentMil: String = ""
    @State var newStartMil: String = ""
    @State var topExpanded = false
    @State var topExpandedService = false
    
    
    var options = ["5000", "7500", "10000"]
    
    var body: some View {
        VStack {
            Gauge(value: Double(currentMil)! , in: Double(startMil)!...Double(startMil)!+Double(selectedInterval)!) {
                Text("\(Image(systemName: "oilcan"))")
                    .font(.system(size: 20))
                    .foregroundColor(.green)
            }
            .gaugeStyle(.accessoryCircularCapacity)
            .tint(.cyan)
            .padding()
            HStack{
                Text("Service in")
                Text("\((Int(startMil)!+Int(selectedInterval)!) - Int(currentMil)!) km")
            }
            
            List {
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
                                    .frame(width: 250)
                                    .foregroundColor(((Int(newStartMil) ?? 0 < Int(startMil)!) || (Int(newStartMil) ?? 0 > 999999) ? .red : .green))
                                    .textFieldStyle(.roundedBorder)
                                
                                Image(systemName:(((Int(newStartMil) ?? 0 < Int(startMil)!) || (Int(newStartMil) ?? 0 > 999999) ? "xmark.circle" : "checkmark.circle")))
                                    .foregroundColor(((Int(newStartMil) ?? 0 < Int(startMil)!) || (Int(newStartMil) ?? 0 > 999999) ? .red : .green))
                            }
                            
                        }
                        Button("OK", action: {
                            startMil = newStartMil
                            topExpandedService = false
                            newStartMil = ""
                            currentMil = startMil
                        })
                        .opacity((Int(newStartMil) ?? 0 < Int(startMil)!) || (Int(newStartMil) ?? 0 > 999999) ? 0.5 : 1.0)
                        .disabled((Int(newStartMil) ?? 0 < Int(startMil)!) || (Int(newStartMil) ?? 0 > 999999))
                        
                        
                    }
                }
            label: {
                HStack {
                    Image(systemName: "gear")
                    Text("Service")
                }
            }
                
                DisclosureGroup(isExpanded: $topExpanded) {
                    VStack {
                        Text("Enter a new mileage value in \(currentMil)...\((Int(startMil) ?? 0) + (Int(selectedInterval) ?? 0)) km")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                            .opacity(0.8)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        HStack {
                            TextField("Current Mileage ", text: $newCurrentMil)
                                .keyboardType(.numberPad)
                                .frame(width: 250)
                                .foregroundColor(((Int(newCurrentMil) ?? 0 < Int(currentMil)!) || (Int(newCurrentMil) ?? 0 > 999999) ? .red : .green))
                                .textFieldStyle(.roundedBorder)
                            Image(systemName:(((Int(newCurrentMil) ?? 0 < Int(currentMil)!) || (Int(newCurrentMil) ?? 0 > 999999) ? "xmark.circle" : "checkmark.circle")))
                                .foregroundColor(((Int(newCurrentMil) ?? 0 < Int(currentMil)!) || (Int(newCurrentMil) ?? 0 > 999999) ? .red : .green))
                        }
                        HStack {
                            Spacer()
                            Button("Cancel", role: .cancel, action: {topExpanded = false})
                                .tint(.red)
                            Spacer()
                            Button("OK", action: {
                                currentMil = newCurrentMil
                                topExpanded = false
                                newCurrentMil = ""
                            })
                            .opacity((Int(newCurrentMil) ?? 0 < Int(currentMil)!) || (Int(newCurrentMil) ?? 0 > 999999) ? 0.5 : 1.0)
                            .disabled((Int(newCurrentMil) ?? 0 < Int(currentMil)!) || (Int(newCurrentMil) ?? 0 > 999999))
                            
                            Spacer()
                        }
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
