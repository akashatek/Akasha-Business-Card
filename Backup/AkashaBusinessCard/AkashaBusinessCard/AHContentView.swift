//
//  ContentView.swift
//  AkashaBusinessCard
//
//  Created by Alvin HEIB on 28/01/2026.
//

import SwiftUI

struct AHContentView: View {
    @Environment(AHDatabase.self) var db: AHDatabase
    @State private var profileID: AHBusinessCard.ID?
    
    var body: some View {
        NavigationSplitView {
            AHBusinessCardProfileView(profileID: $profileID)
                .environment(db)
        } content: {
            if profileID == nil {
                ContentUnavailableView("Please Select or Create a profile", systemImage: "person.fill")
            } else {
                Text("Content")
            }
        } detail: {
            Text("Detail")
        }
    }
}

#Preview {
    AHContentView()
        .environment(AHDatabase.sample)
}
