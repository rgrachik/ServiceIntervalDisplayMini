//
//  info.swift
//  jjj
//
//  Created by Роман Грачик on 19.04.2023.
//

import SwiftUI

struct info: View {
    var body: some View {
        
        ZStack {
            Image("Снимок экрана 2023-04-19 в 18.17.25")
                .resizable()
                .cornerRadius(30)
                .blur(radius: 3)
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 400, height: 300)
                .foregroundColor(.white)
                .opacity(0.4)
            VStack {
                Text("Service Interval Display")
                    .font(.largeTitle)
                Text("Track the oil change interval on your car. When changing the oil, select 'Service' and enter the mileage. Also, select the desired service interval. Further, when using the car, periodically enter the current mileage in the 'Update' field")
            }
            .frame(width: 400, height: 300)        }
    }
}

struct info_Previews: PreviewProvider {
    static var previews: some View {
        info()
    }
}
