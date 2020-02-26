//
//  ViewController.swift
//  Concentration
//
//  Created by Sida on 19/1/20.
//  Copyright © 2020 Sida Yang. All rights reserved.
//

import UIKit

let themes = [
    Theme(backgroundColor: UIColor.white, cardBackColor: UIColor.green, emojis: ["😃", "🥶", "😡", "🤢", "👽", "🤠", "🤡", "🥰", "🤪", "😎"]),
    Theme(backgroundColor: UIColor.black, cardBackColor: UIColor.orange, emojis: ["🐷", "🐸", "🐵", "🐶", "🐴", "🐳", "🐙", "🐠", "🐯", "🦊"]),
    Theme(backgroundColor: UIColor.yellow, cardBackColor: UIColor.cyan, emojis: ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉", "🥏", "🎱"]),
]

class ViewController: UIViewController {
    @IBOutlet var flipCountLabel: UILabel!
    
    @IBOutlet var scoreLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func handleStartNewGame(_ sender: UIButton) {
        viewDidLoad()
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModal()
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    var game: Concentration!
    
    var appliedTheme: Theme!
    
    var numberOfPairsOfCards: Int {
        assert(cardButtons.count % 2 == 0, "Number of cards must be a even number")
        return cardButtons.count / 2
    }
    
    var emoji: [Int: String]!
    
    override func viewDidLoad() {
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        emoji = [Int: String]()
        applyTheme()
        updateViewFromModal()
    }
    
    func applyTheme() {
        appliedTheme = themes.filter { (theme: Theme) -> Bool in
            theme.identifier != appliedTheme?.identifier
        }.randomElement()!
        view.backgroundColor = appliedTheme.backgroundColor
    }
    
    func updateViewFromModal() {
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
        flipCountLabel.text = "Flips: \(game.flipCount)"
        scoreLabel.text = "Score: \(game.score)"
    }

    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, appliedTheme.emojis.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(appliedTheme.emojis.count)))
            emoji[card.identifier] = appliedTheme.emojis.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
}
