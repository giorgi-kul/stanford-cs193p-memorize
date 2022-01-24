//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Giorgi on 1/11/22.
//

import SwiftUI

class EmojiMemoryGame : ObservableObject {
    typealias Card = MemoryGame<String>.Card
    
    static private let numberOfPairOfCards = 10;
    
    private static var emojis = ["✈️", "🚆", "🚤", "🚘", "🚡", "🚖", "🛸","🚝", "🚍", "🛥", "🚀", "🚁", "🛶", "⛵️", "🛳", "🛰", "🛩", "🛫", "🛬"];
    
    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame<String>(numberOfPairsOfCards: numberOfPairOfCards) { index in
            emojis[index]
        }
    }
    
    @Published private var model = createMemoryGame();
    
    var cards : Array<Card>{
        model.cards;
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card : Card) {
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func restart() {
        model = EmojiMemoryGame.createMemoryGame()
    }
}
