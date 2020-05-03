//
//  Concentration.swift
//  Concentration
//
//  Created by Sida on 19/1/20.
//  Copyright © 2020 Sida Yang. All rights reserved.
//

import Foundation

struct Concentration {
    private(set) var cards = [Card]()
    private var flipedUpHistoryInFailedMatch = Set<Card>()
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter{ cards[$0].isFaceUp }.oneAndTheOnlyOne
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    private(set) var score = 0
    private(set) var flipCount = 0
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        if !cards[index].isMatched {
            flipCount += 1
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                flipTheOtherOneCard(at: index, matchIndex: matchIndex)
            } else {
                flipOneCard(at: index)
            }
        }
    }
    
    mutating func flipOneCard(at index: Int) {
        indexOfOneAndOnlyFaceUpCard = index
    }
    
    mutating func flipTheOtherOneCard(at index: Int, matchIndex: Int) {
        if cards[matchIndex] == cards[index] {
            successfulMatch(at: index, matchIndex: matchIndex)
        } else {
            failedMatch(at: index, matchIndex: matchIndex)
        }
        cards[index].isFaceUp = true
    }
    
    mutating func successfulMatch(at index: Int, matchIndex: Int) {
        cards[matchIndex].isMatched = true
        cards[index].isMatched = true
        score += 2
    }
    
    mutating func failedMatch(at index: Int, matchIndex: Int) {
        [index, matchIndex].forEach({
            (currentIndex: Int) in
            if flipedUpHistoryInFailedMatch.contains(cards[currentIndex]) { score -= 1 }
            flipedUpHistoryInFailedMatch.insert(cards[currentIndex])
        })
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at least one pair of cards")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            // deep copy as Card is a struct
            cards += [card, card]
        }
        cards.shuffle()
    }
}


extension Collection {
    var oneAndTheOnlyOne: Element? {
        return count == 1 ? first : nil
    }
}
