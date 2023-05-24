//
//  ParameterDetailView.swift
//  test
//
//  Created by Роман Грачик on 24.05.2023.
//

import SwiftUI

struct ParameterDetailView: View {
    
    var parameter: Parameter

    var body: some View {
        VStack {
            Text("Change mileage \(parameter.startMileage)")
            Text("Interval \(parameter.interval)")
        }
        .navigationTitle(parameter.type)
    }
}

struct ParameterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ParameterDetailView(parameter: Parameter(type: "d", startMileage: 4, interval: 4))
    }
}