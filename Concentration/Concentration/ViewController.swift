//
//  ViewController.swift
//  Concentration
//
//  Created by Sida on 19/1/20.
//  Copyright © 2020 Sida Yang. All rights reserved.
//

import UIKit

let themes = [
    Theme(backgroundColor: UIColor.white, cardBackColor: UIColor.green, emojis: "😃🥶😡🤢👽🤠🤡🥰🤪😎"),
    Theme(backgroundColor: UIColor.black, cardBackColor: UIColor.orange, emojis: "🐷🐸🐵🐶🐴🐳🐙🐠🐯🦊"),
    Theme(backgroundColor: UIColor.yellow, cardBackColor: UIColor.cyan, emojis: "⚽️🏀🏈⚾️🥎🎾🏐🏉🥏🎱"),
]

class ViewController: UIViewController {
    @IBOutlet private var flipCountLabel: UILabel!
    
    @IBOutlet private var scoreLabel: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func handleStartNewGame(_ sender: UIButton) {
        viewDidLoad()
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModal()
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    private var game: Concentration!
    
    private(set) var appliedTheme: Theme!
    
    private var numberOfPairsOfCards: Int {
        assert(cardButtons.count % 2 == 0, "Number of cards must be a even number")
        return cardButtons.count / 2
    }
    
    private var emoji: [Card: String]!
    
    override func viewDidLoad() {
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        emoji = [Card: String]()
        applyTheme()
        updateViewFromModal()
        super.viewDidLoad()
    }
    
    private func applyTheme() {
        appliedTheme = themes.filter { (theme: Theme) -> Bool in
            theme.identifier != appliedTheme?.identifier
        }.randomElement()!
        view.backgroundColor = appliedTheme.backgroundColor
    }
    
    private func updateViewFromModal() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor =
                    card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : appliedTheme.cardBackColor
            }
        }
        let attributes: [NSAttributedString.Key:Any] = [
            .strokeWidth: 5.0,
            .strokeColor: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1),
        ]
        flipCountLabel.attributedText = NSAttributedString(string: "Flips: \(game.flipCount)", attributes: attributes)
        scoreLabel.attributedText = NSAttributedString(string: "Score: \(game.score)", attributes: attributes)
    }
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, appliedTheme.emojis.count > 0 {
            let randomIndex = appliedTheme.emojis.index(appliedTheme.emojis.startIndex, offsetBy: appliedTheme.emojis.count.arc4random)
            emoji[card] = String(appliedTheme.emojis.remove(at: randomIndex))
        }
        return emoji[card] ?? "?"
    }
}


extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
