//
//  BusinessCardView.swift
//  AkashaBusinessCard
//
//  Created by Alvin HEIB on 09/02/2026.
//

import SwiftUI

struct BusinessCardView: View {
    let businessCard: BusinessCard
    let profileName: String
    
    var body: some View {
        VStack(spacing: 24) {
            // Virtual Business Card Preview
            VirtualBusinessCardView(businessCard: businessCard)
                .scaleEffect(0.8)
                .frame(width: 320, height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
        }
        .padding()
        .navigationTitle(profileName)
    }
}

#Preview {
    NavigationStack {
        BusinessCardView(
            businessCard: BusinessCard(firstname: "Alvin", lastname: "Heib"),
            profileName: "Alvin Heib"
        )
    }
}
