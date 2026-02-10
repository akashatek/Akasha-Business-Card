//
//  AHBusinessCard.swift
//  AkashaBusinessCard
//
//  Created by Alvin HEIB on 28/01/2026.
//

import Foundation

struct AHBusinessCard: Identifiable {
    var id: UUID
    var profile: String
    var fullName: String?
    var email: String?
    var phone: String?
    var address: String?
    var photo: String?
    var company: String?
    var title: String?
    var logo: String?
}
