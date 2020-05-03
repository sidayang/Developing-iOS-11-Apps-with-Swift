//
//  ViewController.swift
//  Set
//
//  Created by Sida Yang on 29/3/20.
//  Copyright © 2020 Sida Yang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var INITIAL_DISPLAY_CARD_QUANTITYL: Int = 12
    
    var MAX_DISPLAY_CARD_QUANTITY: Int {
        return cardUIButtons.count
    }
    
    var selectedCardUIBUtton: [CardUIButton] {
        return cardUIButtons.filter{ $0.isSelectedCard }
    }
    
    var isCurrentSelectionMatched: Bool {
        return checkCardMatch(cards: selectedCardUIBUtton.map{(cardUIButton : CardUIButton) in cardUIButton.card!})
    }
    
    var score: Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
        
    var deck: [Card]!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet var cardUIButtons: [CardUIButton]!
    
    @IBAction func handleTouchCardUIButton(_ sender: CardUIButton) {
        if selectedCardUIBUtton.count < 3 {
            if sender.isSelectedCard {
                score -= 1
            }
            sender.toggleSelectionStatus()
            if selectedCardUIBUtton.count == 3 {
                if isCurrentSelectionMatched {
                    score += 5
                } else {
                    score -= 3
                }
            }
        } else {
            if isCurrentSelectionMatched {
                if !selectedCardUIBUtton.contains(sender) {
                    dealCardToSelection()
                    sender.toggleSelectionStatus();
                }
            } else {
                selectedCardUIBUtton.forEach{(cardUIButton : CardUIButton) in cardUIButton.isSelectedCard = false}
                sender.toggleSelectionStatus();
            }
        }
        updateState()
    }
    
    @IBAction func handleDealThreeMore(_ sender: Any) {
        if isCurrentSelectionMatched {
            dealCardToSelection()
        } else {
            dealCardsToRandomCardUIButton(quantity: 3)
        }
        updateState()
    }
    @IBOutlet weak var dealThreeMoreButton: UIButton!
    
    @IBAction func handleNewGame(_ sender: Any) {
        initialize()
    }
    
    func dealCardToSelection() {
        selectedCardUIBUtton.forEach{(cardUIButton : CardUIButton) in cardUIButton.card = dealCard()}
    }
    
    func updateState() {
        dealThreeMoreButton.isEnabled = (!(emptyCardUIButtons.count <= 0 || deck.count <= 0)) || isCurrentSelectionMatched
    }
    
    func checkCardMatch(cards: [Card]) -> Bool {
        if cards.count < 3 {
            return false;
        }
        var isSameNumberMatch: Bool?
        var isSameShapeMatch: Bool?
        var isSameShadingMatch: Bool?
        var isSameColorMatch: Bool?
        for i in 1..<cards.count {
            if isSameNumberMatch == nil {
                isSameNumberMatch = cards[i].attributes.0 == cards[i - 1].attributes.0
            } else {
                if isSameNumberMatch != (cards[i].attributes.0 == cards[i - 1].attributes.0) {
                    return false
                }
            }
            if isSameShapeMatch == nil {
                isSameShapeMatch = cards[i].attributes.1 == cards[i - 1].attributes.1
            } else {
                if isSameShapeMatch != (cards[i].attributes.1 == cards[i - 1].attributes.1) {
                    return false
                }
            }
            if isSameShadingMatch == nil {
                isSameShadingMatch = cards[i].attributes.2 == cards[i - 1].attributes.2
            } else {
                if isSameShadingMatch != (cards[i].attributes.2 == cards[i - 1].attributes.2) {
                    return false
                }
            }
            if isSameColorMatch == nil {
                isSameColorMatch = cards[i].attributes.3 == cards[i - 1].attributes.3
            } else {
                if isSameColorMatch != (cards[i].attributes.3 == cards[i - 1].attributes.3) {
                    return false
                }
            }
        }
        return true
    }
    
    
    var emptyCardUIButtons: [CardUIButton] {
        return cardUIButtons.filter{ $0.card == nil }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    func initialize() {
        score = 0
        cardUIButtons.forEach{(cardUIButton: CardUIButton) in cardUIButton.card = nil}
        deck = CardUIButton.allPossibleCards.shuffled()
        dealCardsToRandomCardUIButton(quantity: INITIAL_DISPLAY_CARD_QUANTITYL)
        updateState()
    }
    
    func dealCardsToRandomCardUIButton(quantity: Int) {
        for _ in 0..<quantity {
            emptyCardUIButtons.randomElement()?.card = dealCard()
        }
    }
    
    func dealCard() -> Card? {
        return deck.count > 0 ? deck.remove(at: 0) : nil
    }
    
}
