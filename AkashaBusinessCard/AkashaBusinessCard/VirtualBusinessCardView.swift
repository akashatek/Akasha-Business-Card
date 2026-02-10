//
//  VirtualBusinessCardView.swift
//  AkashaBusinessCard
//
//  Created by Alvin HEIB on 09/02/2026.
//

import SwiftUI

struct VirtualBusinessCardView: View {
    let businessCard: BusinessCard
    
    private let cardWidth: CGFloat = 400
    private let cardHeight: CGFloat = 250
    
    var body: some View {
        VStack(spacing: 16) {
            // Profile Image
            Image(businessCard.profileImage ?? "unknown-person")
                .resizable()
                .frame(width: 120, height: 120)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.accentColor.opacity(0.3), lineWidth: 4)
                )
            // First Name
            Text(businessCard.firstname + " " + businessCard.lastname)
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(.primary)
        }
        .frame(width: cardWidth, height: cardHeight)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
}

#Preview {
    VirtualBusinessCardView(businessCard: .defaultCard)
}
