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
struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier: Int

    static var identifierFactory = 0

    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }

    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
