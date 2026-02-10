//
//  AkashaBusinessCardApp.swift
//  AkashaBusinessCard
//
//  Created by Alvin HEIB on 09/02/2026.
//

import SwiftUI
import SwiftData

@main
struct AkashaBusinessCardApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            BusinessCard.self,
            BusinessCardProfile.self,
        ])
        let modelConfiguration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: false,
            allowsSave: true,
            groupContainer: .identifier("group.com.akashatek.AkashaBusinessCard"),
            cloudKitDatabase: .none
        )

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            // Fallback to in-memory only if persistent storage fails
            let fallbackConfig = ModelConfiguration(
                schema: schema,
                isStoredInMemoryOnly: true
            )
            do {
                return try ModelContainer(for: schema, configurations: [fallbackConfig])
            } catch {
                fatalError("Could not create ModelContainer: \(error)")
            }
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
