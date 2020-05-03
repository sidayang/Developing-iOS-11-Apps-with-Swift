//
//  Theme.swift
//  Concentration
//
//  Created by Sida on 25/2/20.
//  Copyright © 2020 Sida Yang. All rights reserved.
//

import Foundation
import UIKit

struct Theme {
    var identifier: Int
    var backgroundColor: UIColor
    var cardBackColor: UIColor
    var emojis: String
    
    static var identifierFactory = 0

    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }

    init(backgroundColor: UIColor, cardBackColor: UIColor, emojis: String) {
        self.backgroundColor = backgroundColor
        self.cardBackColor = cardBackColor
        self.emojis = emojis
        self.identifier = Theme.getUniqueIdentifier()
    }
}
