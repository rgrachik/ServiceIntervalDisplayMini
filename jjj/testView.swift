//
//  testView.swift
//  jjj
//
//  Created by Роман Грачик on 18.04.2023.
//

import SwiftUI

struct testView: View {
    
    @State var isExpanded = false
    
    var body: some View {
        DisclosureGroup(isExpanded: $isExpanded) {
            // ...
        } label: {
            HStack {
                Image(systemName: "gear")
                Text("Settings")
            }
        }

    }
}

struct testView_Previews: PreviewProvider {
    static var previews: some View {
        testView()
    }
}
