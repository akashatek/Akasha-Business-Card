//
//  ContentView.swift
//  AkashaBusinessCard
//
//  Created by Alvin HEIB on 28/01/2026.
//

import SwiftUI

struct ContentView: View {
    @Environment(AHDatabase.self) var db: AHDatabase
    
    var body: some View {
        NavigationSplitView {
            
        } content: {
            
        } detail: {
            
        }
    }
}

#Preview {
    ContentView()
        .environment(AHDatabase(true))
}
