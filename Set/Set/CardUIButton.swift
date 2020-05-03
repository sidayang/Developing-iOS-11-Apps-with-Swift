//
//  CardUIButton.swift
//  Set
//
//  Created by Sida Yang on 1/4/20.
//  Copyright © 2020 Sida Yang. All rights reserved.
//

import Foundation
import UIKit

class CardUIButton: UIButton {
    
    enum ENumbers: Int, CaseIterable {
        case one = 1
        case two = 2
        case three = 3
    }
       
    enum EShapes: String, CaseIterable {
        case triangle = "▲"
        case circle = "●"
        case square = "■"
    }
    
    enum EShadings: String, CaseIterable {
        case striped
        case filled
        case stroked
    }
    
    enum EColor: CaseIterable {
        case black
        case orange
        case red
    }
    
    var card: Card? {
        didSet {
            initialize()
        }
    }
    
    var isSelectedCard: Bool = false {
        didSet {
            self.layer.backgroundColor = isSelectedCard ? #colorLiteral(red: 0.3921568627, green: 0.8235294118, blue: 1, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    func toggleSelectionStatus() {
        if card != nil {
            isSelectedCard = !isSelectedCard
        }
    }
    
    func initialize(){
        self.isSelectedCard = false
        if card?.attributes == nil {
            setEmptyCard()
            return
        }
        let (number, shape, shading, color) = card!.attributes
        let uiColor: UIColor = { color in
            switch color {
            case .black:
                return UIColor.black
            case .orange:
                return UIColor.orange
            case .red:
                return UIColor.red
            }
        }(color)
        var attributes: [NSAttributedString.Key:Any] = [
            .strokeColor: uiColor as UIColor,
            .font: UIFont.systemFont(ofSize: 20)
        ]
        switch shading {
        case .filled:
            attributes[.foregroundColor] = uiColor as UIColor
        case .striped:
            attributes[.foregroundColor] = uiColor.withAlphaComponent(0.15) as UIColor
        case .stroked:
            attributes[.strokeWidth] = 8.0 as CGFloat
        }
        var stringArray: [String] = []
        for _ in 0..<number.rawValue {
            stringArray.append(shape.rawValue)
        }
        let attributedString = NSAttributedString(string: stringArray.joined(separator: " "), attributes:attributes )
        self.isEnabled = true
        self.layer.cornerRadius = 8
        self.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.layer.borderColor = #colorLiteral(red: 0.6679978967, green: 0.4751212597, blue: 0.2586010993, alpha: 1)
        self.layer.borderWidth = 2
        self.setAttributedTitle(attributedString, for: .normal)
    }
    
    func setEmptyCard() {
        self.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        self.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        self.isEnabled = false
        self.setAttributedTitle(NSAttributedString(string: ""), for: .normal)
    }
}

extension CardUIButton {
    static var allPossibleCards: [Card] {
        var result: [Card] = []
        CardUIButton.ENumbers.allCases.forEach{(number: CardUIButton.ENumbers)  in
            CardUIButton.EShapes.allCases.forEach{(shape: CardUIButton.EShapes)  in
                CardUIButton.EShadings.allCases.forEach{(shading: CardUIButton.EShadings)  in
                    CardUIButton.EColor.allCases.forEach{(color: CardUIButton.EColor)  in
                        result.append(Card(attributes: (number, shape, shading, color)))
                    }
                }
            }
        }
        return result
    }
}
