//
//  main.swift
//  jjj
//
//  Created by Роман Грачик on 13.04.2023.
//

import SwiftUI



struct mainView: View {
    
    let opacityColor = Color(red: 1, green: 0.5, blue: 0, opacity: 0)
    
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
        case 100...:
            return opacityColor
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
    
    var txt: String {
        let serviceIn = ((Int(startMil)!+Int(selectedInterval)!) - Int(currentMil)!)
        switch serviceIn {
        case 0...:
            return "Service in"
        default:
            return "Overrun is"
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
            ZStack{
                Text("\(Image(systemName: ((Int(startMil)!+Int(selectedInterval)!) - Int(currentMil)!) >= 0 ? "oilcan" : "oilcan.fill"))")
                    .font(.system(size: ((Int(startMil)!+Int(selectedInterval)!) - Int(currentMil)!) >= 0 ? 20 : 70))
                    .foregroundColor(canTintColor)
                
                Gauge(value: Double(currentMil)! , in: Double(startMil)!...Double(startMil)!+Double(selectedInterval)!) {
                    
                }
                .gaugeStyle(.accessoryCircularCapacity)
                .tint(tintColor)
            }
            // MARK: text service
            
            Text(txt + " " + "\(((Int(startMil)!+Int(selectedInterval)!) - Int(currentMil)!)) km")
            
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
                                            newStartMil = ""
                                        })  {
                                            Image(systemName:"xmark.circle")
                                                .foregroundColor(.gray)
                                        }
                                            .padding(.trailing, 8)
                                            .opacity(newStartMil.isEmpty ? 0 : 1),
                                        alignment: .trailing
                                    )
                                    .toolbar {
                                        ToolbarItem(placement: .keyboard) {
                                            Button("OK") {
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
                                            }
                                        }
                                    }
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
                                
                                Button(action: {newCurrentMil = ""})  {
                                    Image(systemName:"xmark.circle")
                                        .foregroundColor(.gray)
                                }
                                    .padding(.trailing, 8)
                                    .opacity(newCurrentMil.isEmpty ? 0 : 1),
                                alignment: .trailing
                            )
                            .toolbar {
                                ToolbarItem(placement: .keyboard) {
                                    Button("OK") {
                                        if let newCurrentMilInt = Int(newCurrentMil),
                                           let currentMilInt = Int(currentMil),
                                           (newCurrentMilInt >= currentMilInt && newCurrentMilInt <= 999999) {
                                            currentMil = newCurrentMil
                                            topExpanded = false
                                            newCurrentMil = ""
                                        } else {
                                            newCurrentMil = ""
                                        }
                                    }
                                }
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
