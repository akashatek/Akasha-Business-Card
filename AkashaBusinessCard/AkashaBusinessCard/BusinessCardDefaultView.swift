//
//  BusinessCardView.swift
//  AkashaBusinessCard
//
//  Created by Alvin HEIB on 28/01/2026.
//

import SwiftUI

struct BusinessCardDefaultView: View {
    var card: BusinessCard
    
    var body: some View {
        HStack {
            
        }
        .frame(width: 971, height: 536)
        .padding(63)
    }
}

#Preview {
    BusinessCardDefaultView(card: BusinessCard())
}
