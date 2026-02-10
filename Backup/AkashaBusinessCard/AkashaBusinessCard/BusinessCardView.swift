//
//  BusinessCardView.swift
//  AkashaBusinessCard
//
//  Created by Alvin HEIB on 28/01/2026.
//

import SwiftUI

struct BusinessCardView: View {
    var card: BusinessCard
    let originalSize = CGSize(width: 917, height: 536) // The view's intrinsic size

    var body: some View {
        GeometryReader { proxy in
            let availableSize = proxy.size
            // Calculate the minimum scaling factor to ensure the whole view fits
            
            let scalingFactor = min(availableSize.width / originalSize.width, availableSize.height / originalSize.height)

            BusinessCardDefaultView(card: card) // Your custom view
                .scaleEffect(scalingFactor, anchor: .topLeading) // Apply the scaling
                .frame(width: availableSize.width, height: availableSize.height, alignment: .topLeading) // Fill the available space with the scaled view
                .padding()
        }
    }
}

#Preview {
    BusinessCardView(card: BusinessCard())
}
