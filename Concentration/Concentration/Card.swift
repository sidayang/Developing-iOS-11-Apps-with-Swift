//
//  Card.swift
//  Concentration
//
//  Created by Sida on 19/1/20.
//  Copyright © 2020 Sida Yang. All rights reserved.
//

import Foundation

// no inheritance
// structs are value types
// free initializer where all properties can be passed
struct Card: Hashable {
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int

    private static var identifierFactory = 0

    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }

    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
