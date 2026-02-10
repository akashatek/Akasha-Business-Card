//
//  AHBusinessCardProfileView.swift
//  AkashaBusinessCard
//
//  Created by Alvin HEIB on 28/01/2026.
//

import SwiftUI

struct AHBusinessCardProfileView: View {
    @Environment(AHDatabase.self) var db: AHDatabase
    @Binding var profileID: AHBusinessCard.ID?
    @State private var newProfileName: String = ""
    
    var body: some View {
        VStack {
            List(selection: $profileID) {
                ForEach(db.cards) { card in
                    Text(card.profile)
                }
            }.padding()
            HStack {
                TextField("New Profile ...", text: $newProfileName)
                    .onSubmit {
                        createCard(profile: newProfileName)
                    }
                Button("Add") {
                    createCard(profile: newProfileName)
                }
            }.padding()
        }
    }
    
    func createCard(profile: String) {
        db.createCard(profile: newProfileName)
        newProfileName = ""
    }
}

#Preview {
    AHBusinessCardProfileView(profileID: .constant(nil))
        .environment(AHDatabase.sample)
}
