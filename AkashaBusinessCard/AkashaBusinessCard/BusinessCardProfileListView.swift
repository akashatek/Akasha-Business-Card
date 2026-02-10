//
//  BusinessCardProfileListView.swift
//  AkashaBusinessCard
//
//  Created by Alvin HEIB on 09/02/2026.
//

import SwiftUI
import SwiftData

struct BusinessCardProfileListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \BusinessCardProfile.name) private var profiles: [BusinessCardProfile]
    
    @Binding var selectedProfile: BusinessCardProfile?
    
    @State private var newProfileName: String = ""
    
    var body: some View {
        VStack {
            List(selection: $selectedProfile) {
                ForEach(profiles, id: \.id) { profile in
                    Text(profile.name)
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(role: .destructive) {
                                deleteProfile(profile)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                    }
                }
                .onMove(perform: moveProfile)
            }
            HStack {
                TextField("", text: $newProfileName)
                    .onSubmit {
                        addProfile()
                    }
                Button("Add") {
                    addProfile()
                }
            }.padding()
        }
    }
    
    func addProfile() {
        let card = BusinessCard(firstname: "", lastname: "")
        let profile = BusinessCardProfile(name: newProfileName, businessCard: card)
        modelContext.insert(profile)
        
        newProfileName = ""
    }

    func deleteProfile(_ profile: BusinessCardProfile) {
        modelContext.delete(profile)
    }
    
    func moveProfile(from source: IndexSet, to destination: Int) {
        // Move logic for profiles would go here
        // This assumes profiles are moved in the same order as they appear in the list
        let movedProfiles = profiles[source].sorted { $0.name < $1.name }
        var updatedProfiles = profiles
        updatedProfiles.remove(atOffsets: source)
        updatedProfiles.insert(contentsOf: movedProfiles, at: destination)
    }
}

#Preview {
    NavigationStack {
        BusinessCardProfileListView(selectedProfile: .constant(nil))
            .modelContainer(for: BusinessCardProfile.self, inMemory: true)
    }
}
