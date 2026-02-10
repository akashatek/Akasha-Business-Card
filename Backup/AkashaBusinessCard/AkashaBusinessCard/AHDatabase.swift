//
//  AHDatabase.swift
//  AkashaBusinessCard
//
//  Created by Alvin HEIB on 28/01/2026.
//

import Foundation
import SwiftData

@Observable
class AHDatabase {
    var cards: [AHBusinessCard] = []
    
    static var sample: AHDatabase {
        let db = AHDatabase()
        db.cards = [
            AHBusinessCard(id: UUID(), profile: "Work", fullName: "Alvin Heib", email: "heibalvin@akashatek.com", phone: "+33 (0)6 74 78 78 60", photo: "alvin-heib", company: "AkashaTek", title: "Global Partnership Advisor", logo: "akasha-tek-logo-512x512"),
            AHBusinessCard(id: UUID(), profile: "Personal", fullName: "Alvin Heib", email: "heibalvin@gmail.com", phone: "+971 (0) 58 889 1030", address: "villa 3 - Centro Courtyard 3 (CC3) - the Villa - Duabiland - Dubai, UAE", photo: "alvin-heib-ai-doll-picture")
        ]
        return db
    }
    
    func getFirstCard() -> AHBusinessCard? {
        return cards.first
    }
    
    func createCard(profile: String) {
        cards.append(AHBusinessCard(id: UUID(), profile: profile))
    }
}
