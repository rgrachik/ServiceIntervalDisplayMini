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

    var body: some View {
        VStack {
            Text("\($car.wrappedValue.currentMileage)") // Обращайтесь к wrappedValue для доступа к обернутому значению свойства Binding
            Text("Change mileage \(parameter.startMileage)")
            Text("Interval \(parameter.interval)")
        }
        .navigationTitle(parameter.type)
    }
}

struct ParameterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ParameterDetailView(parameter: Parameter(type: "d", startMileage: 4, interval: 4), car: .constant(Car()))
    }
}
