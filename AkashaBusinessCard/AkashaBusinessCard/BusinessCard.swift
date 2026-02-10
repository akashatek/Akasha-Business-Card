//
//  BusinessCard.swift
//  AkashaBusinessCard
//
//  Created by Alvin HEIB on 09/02/2026.
//

import Foundation
import SwiftData

@Model
final class BusinessCard {
    var id: UUID
    var firstname: String
    var lastname: String
    var profileImage: String?
    
    init(id: UUID = UUID(), firstname: String = "", lastname: String = "", profileImage: String? = nil) {
        self.id = id
        self.firstname = firstname
        self.lastname = lastname
        self.profileImage = profileImage
    }
}

// MARK: - Default Profiles
extension BusinessCard {
    static var defaultCard: BusinessCard {
        BusinessCard(firstname: "Alvin", lastname: "Heib")
    }
    
    static var akashaTekCard: BusinessCard {
        BusinessCard(firstname: "Akasha", lastname: "Tek")
    }
}

// MARK: - BusinessCard Profile
@Model
final class BusinessCardProfile {
    var id: UUID
    var name: String
    
    @Relationship(deleteRule: .cascade)
    var businessCard: BusinessCard?
    
    init(id: UUID = UUID(), name: String, businessCard: BusinessCard? = nil) {
        self.id = id
        self.name = name
        self.businessCard = businessCard
    }
}

// MARK: - Default Profile Extensions
extension BusinessCardProfile {
    static var defaultProfile: BusinessCardProfile {
        BusinessCardProfile(name: "Default", businessCard: .defaultCard)
    }
    
    static var akashaTekProfile: BusinessCardProfile {
        BusinessCardProfile(name: "Akasha Tek", businessCard: .akashaTekCard)
    }
}
