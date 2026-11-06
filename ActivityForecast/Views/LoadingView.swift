//
//  LoadingView.swift
//  ActivityForecast
//
//  Created by Amol Bombe on 06/11/26.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        List {
            ForEach(0..<10) { _ in
                Text("Placeholder text for loading")
            }
        }
        .redacted(reason: .placeholder)
    }
}

#Preview {
    LoadingView()
}
