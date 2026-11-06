//
//  ErrorView.swift
//  ActivityForecast
//
//  Created by Amol Bombe on 06/11/26.
//

import SwiftUI

struct ErrorView: View {
    let meassage: String
    
    var body: some View {
        VStack {
            Text(meassage)
                .font(.callout)
                .padding()
        }
    }
}

#Preview {
    ErrorView(meassage: "Something went wrong")
}
