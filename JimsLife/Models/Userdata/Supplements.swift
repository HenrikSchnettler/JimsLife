//
//  Supplements.swift
//  JimsLife
//
//  Created by Henrik Schnettler on 17.04.21.
//

import SwiftUI

struct Supplement: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var imageName: String
    var categorie: Category
    var description: String
    var icon: String
    
    enum Category: String, CaseIterable, Codable, Hashable {
        case supplement = "supplement"
        case food = "food"
    }
}

struct DoneSupplement: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var imageName: String
    var categorie: Category
    var description: String
    var icon: String
    
    enum Category: String, CaseIterable, Codable, Hashable {
        case supplement = "supplement"
        case food = "food"
    }
}
