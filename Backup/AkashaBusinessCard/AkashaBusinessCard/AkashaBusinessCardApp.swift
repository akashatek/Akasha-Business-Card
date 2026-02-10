//
//  AkashaBusinessCardApp.swift
//  AkashaBusinessCard
//
//  Created by Alvin HEIB on 28/01/2026.
//

import SwiftUI

@main
struct AkashaBusinessCardApp: App {
    @State var db: AHDatabase = AHDatabase.sample
    
    var body: some Scene {
        WindowGroup {
            AHContentView()
                .environment(db)
        }
    }
}
