//
//  test.swift
//  jjj
//
//  Created by Роман Грачик on 18.04.2023.
//

import SwiftUI

struct test: View {
    @State var goo = ""
    var body: some View {
        TextField("Current Mileage ", text: $goo)
            .textFieldStyle(.roundedBorder)
            .overlay(
                Button(action: {
                    self.goo = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.secondary)
                }
                    .padding(.trailing, 8)
                    .opacity(goo.isEmpty ? 0 : 1),
                alignment: .trailing
            )
    }
    
}

struct test_Previews: PreviewProvider {
    static var previews: some View {
        test()
    }
}
