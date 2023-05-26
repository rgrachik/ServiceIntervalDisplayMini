//
//  ParameterDetailView.swift
//  test
//
//  Created by Роман Грачик on 24.05.2023.
//

import SwiftUI

struct ParameterDetailView: View {
    var parameter: Parameter
    @Binding var car: Car

    private let wearCalculator = WearCalculator()

    var body: some View {
        VStack {
            Text("\($car.wrappedValue.currentMileage)")
            Text("Change mileage \(parameter.startMileage)")
            Text("Interval \(parameter.interval)")
            Gauge(value: wearCalculator.calculateWear(for: parameter, currentMileage: car.currentMileage), label: {})
                .padding()
        }
        .navigationTitle(parameter.type)
    }
}


struct ParameterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ParameterDetailView(parameter: Parameter(type: "d", startMileage: 4, interval: 4), car: .constant(Car()))
    }
}
