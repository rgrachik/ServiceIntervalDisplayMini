//
//  main.swift
//  jjj
//
//  Created by Роман Грачик on 13.04.2023.
//

import SwiftUI



struct mainView: View {
    
    var tintColor: Color {
        
        let percentOfVear = Int((Double(currentMil)! - Double(startMil)!) / Double(selectedInterval)! * 100)
        
        let value = percentOfVear
        switch value {
        case 0...60:
            return .green
        case 61...95:
            return .orange
        case 96...100:
            return .red
        default:
            return .gray
        }
    }
    
    var canTintColor: Color {
        let serviceIn = ((Int(startMil)!+Int(selectedInterval)!) - Int(currentMil)!)
        switch serviceIn {
        case 1...999999:
            return .green
        case ...0:
            return .red
        default:
            return .gray
        }
    }
    
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
        VStack (alignment: .center, spacing: 20) {
// MARK: Gauge
            Gauge(value: Double(currentMil)! , in: Double(startMil)!...Double(startMil)!+Double(selectedInterval)!) {
                Text("\(Image(systemName: ((Int(startMil)!+Int(selectedInterval)!) - Int(currentMil)!) >= 0 ? "oilcan" : "oilcan.fill"))")
                    .font(.system(size: 20))
                    .foregroundColor(canTintColor)
            }
            .gaugeStyle(.accessoryCircularCapacity)
            .tint(tintColor)
            .padding()
            
            // MARK: text service
            
                Text("Service in \((Int(startMil)!+Int(selectedInterval)!) - Int(currentMil)!) km")
            
            
            List {
                
// MARK: 1st DisclosureGroup
                
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
                                                startMil = newStartMil
                                                currentMil = startMil
                                                topExpandedService = false
                                                newStartMil = ""
                                            } else {
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
                            Text("The current mileage progress will be reset")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.system(size: 12))
                                .foregroundColor(.orange)
                        }
                    }
                }
            label: {
                HStack {
                    Image(systemName: "gear")
                    Text("Service")
                }
            }
                
// MARK: 2st DisclosureGroup
                
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
                                        currentMil = newCurrentMil
                                        topExpanded = false
                                        newCurrentMil = ""
                                    } else {
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
            .listStyle(.plain)
        }
        .frame(maxWidth: .infinity, maxHeight: 500)
        .scrollDisabled(true)
// MARK: Save in UserDefaults
        
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
