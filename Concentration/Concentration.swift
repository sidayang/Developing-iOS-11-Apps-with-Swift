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
    var flipedUpHistoryInFailedMatch = Set<Int>()
    var indexOfOneAndOnlyFaceUpCard: Int?
    var score = 0
    var flipCount = 0
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            flipCount += 1
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                flipTheOtherOneCard(at: index, matchIndex: matchIndex)
            } else {
                flipOneCard(at: index)
            }
        }
    }
    
    func flipOneCard(at index: Int) {
        for flipDownIndex in cards.indices {
            cards[flipDownIndex].isFaceUp = false
        }
        cards[index].isFaceUp = true
        indexOfOneAndOnlyFaceUpCard = index
    }
    
    func flipTheOtherOneCard(at index: Int, matchIndex: Int) {
        if cards[matchIndex].identifier == cards[index].identifier {
            successfulMatch(at: index, matchIndex: matchIndex)
        } else {
            failedMatch(at: index, matchIndex: matchIndex)
        }
        cards[index].isFaceUp = true
        indexOfOneAndOnlyFaceUpCard = nil
    }
    
    func successfulMatch(at index: Int, matchIndex: Int) {
        cards[matchIndex].isMatched = true
        cards[index].isMatched = true
        score += 2
    }
    
    func failedMatch(at index: Int, matchIndex: Int) {
        [index, matchIndex].forEach({
            (currentIndex: Int) in
            if flipedUpHistoryInFailedMatch.contains(currentIndex) { score -= 1 }
            flipedUpHistoryInFailedMatch.insert(cards[currentIndex].identifier)
        })
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            // deep copy as Card is a struct
            cards += [card, card]
        }
        cards.shuffle()
    }
}
