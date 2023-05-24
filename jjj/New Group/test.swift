//
//  test.swift
//  test
//
//  Created by Роман Грачик on 24.05.2023.
//

import SwiftUI

struct test: View {
    var body: some View {
        NavigationStack{
            List{
                NavigationLink("sss", destination: MainView())
                Text("dd")
            }
        }
        
    }
}

struct test_Previews: PreviewProvider {
    static var previews: some View {
        test()
    }
}
