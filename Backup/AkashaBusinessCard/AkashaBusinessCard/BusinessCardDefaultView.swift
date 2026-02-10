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
        ZStack {
            Image("black-metal-textured")
            
            HStack {
                VStack(alignment: .leading) {
                    VStack(alignment: .center) {
                        Image(card.photo).resizable().scaledToFit().frame(width: 150, height: 150).clipShape(.circle)
                        Text(card.fullName).font(.title)
                    }.padding()
                    Spacer()
                    VStack(alignment: .leading) {
                        Text(card.title).font(.title2)
                        Text(card.email).font(.title2)
                        Text(card.mobile).font(.title2)
                    }.padding()
                }.padding()
                Spacer()
                Divider()
                Spacer()
                VStack(alignment: .trailing) {
                    VStack(alignment: .center) {
                        Image(card.logo).resizable().frame(width: 150, height: 150)
                        Text(card.organisation).font(.title)
                    }.padding()
                    Spacer()
                    VStack(alignment: .center) {
                        card.QRCodeGen(from: card.vCardGen()).resizable().frame(width: 150, height: 150)
                    }.padding()
                }.padding()
            }
            .foregroundColor(.white)
        }
    }
}

#Preview {
    BusinessCardDefaultView(card: BusinessCard())
}
