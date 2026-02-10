//
//  ContentView.swift
//  AkashaBusinessCard
//
//  Created by Alvin HEIB on 09/02/2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \BusinessCardProfile.name) private var profiles: [BusinessCardProfile]
    
    @State private var selectedProfile: BusinessCardProfile?
    
    var body: some View {
        NavigationSplitView {
            BusinessCardProfileListView(selectedProfile: $selectedProfile)
        } detail: {
            // Content - Card View
            if let profile = selectedProfile, let card = profile.businessCard {
                BusinessCardView(businessCard: card, profileName: profile.name)
            } else {
                ContentUnavailableView(
                    "Select a Profile",
                    systemImage: "person.crop.rectangle",
                    description: Text("Choose a profile to view")
                )
            }
        }
        .onAppear {
            if profiles.isEmpty {
                createSampleProfiles()
            } else if selectedProfile == nil {
                selectedProfile = profiles.first
            }
        }
    }
    
    private func createSampleProfiles() {
        // Sample 1: Alvin Heib
        let card1 = BusinessCard(firstname: "Alvin", lastname: "Heib")
        let profile1 = BusinessCardProfile(name: "Alvin Heib", businessCard: card1)
        modelContext.insert(profile1)
        
        // Sample 2: Akasha Tek
        let card2 = BusinessCard(firstname: "Akasha", lastname: "Tek")
        let profile2 = BusinessCardProfile(name: "Akasha Tek", businessCard: card2)
        modelContext.insert(profile2)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: BusinessCardProfile.self, inMemory: true)
}
