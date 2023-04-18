//
//  main.swift
//  jjj
//
//  Created by Роман Грачик on 13.04.2023.
//

import SwiftUI
import Combine

struct mainView: View {
    
    var tintColor: Color {
        let value = Int((Double(currentMil)! - Double(startMil)!)/Double(selectedInterval)! * 100)

        switch value {
        case 0...60:
            return .green
        case 61...90:
            return .yellow
        case 91...99:
            return .orange
        default:
            return .red
        }
    }
    
    @State var selectedInterval = UserDefaults.standard.string(forKey: "selectedInterval") ?? "7500"
    @State var presentAlert = false
    @State var currentMil: String = UserDefaults.standard.string(forKey: "currentMil") ?? "\(11000)"
    @State var startMil: String = UserDefaults.standard.string(forKey: "startMil") ?? "\(10000)"
    @State var newCurrentMil: String = ""
    @State var newStartMil: String = ""
    @State var topExpanded = false
    
   
    
    var body: some View {
        NavigationStack{
            
            VStack {
                Gauge(value: Double(currentMil)! , in: Double(startMil)!...Double(startMil)!+Double(selectedInterval)!) {
                    Text("\(Image(systemName: "oilcan"))")
                        .font(.system(size: 20))
                        .foregroundColor(.green)
                }
                .gaugeStyle(.accessoryCircularCapacity)
                .tint(tintColor)
                .padding()
                
                
                HStack{
                    Text("Service in")
                    Text("\((Int(startMil)!+Int(selectedInterval)!) - Int(currentMil)!) km")
                    
//                    Проверка значения процента износа масла
                    
//                    Text("\(Int((Double(currentMil)! - Double(startMil)!)/Double(selectedInterval)! * 100))")
                    
                }
                .padding()
                
                NavigationLink(destination: ChangeView(selectedInterval: $selectedInterval, presentAlert: $presentAlert, startMil: $startMil, newStartMil: $newStartMil), label: {Text("Service")})
                
                
                
                DisclosureGroup("Update mileage", isExpanded: $topExpanded) {
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
                        Button("reset to 11000", action: {currentMil = "\(11000)"})
                    }
                }
                
                .padding()
                
                
            }
            .onDisappear {
                UserDefaults.standard.set(selectedInterval, forKey: "selectedInterval")
                UserDefaults.standard.set(currentMil, forKey: "currentMil")
                UserDefaults.standard.set(startMil, forKey: "startMil")
            }
        }
    }
    
}
extension Int {
    func isWithin(_ range: ClosedRange<Int>) -> Bool {
        return range.contains(self)
    }
}



struct main_Previews: PreviewProvider {
    static var previews: some View {
        mainView()
    }
}
