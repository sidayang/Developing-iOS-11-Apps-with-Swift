//
//  Concentration.swift
//  Concentration
//
//  Created by Sida on 19/1/20.
//  Copyright © 2020 Sida Yang. All rights reserved.
//

import Foundation

class Concentration {
    var cards = [Card]()

    var indexOfOneAndOnlyFaceUpCard: Int?

    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }

    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            // deep copy as Card is a struct
            cards += [card, card]
        }
        // TODO: Shuffle the cards
    }
}
