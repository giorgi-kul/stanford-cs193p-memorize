//
//  MemoryGame.swift
//  Memorize
//
//  Created by Giorgi on 1/11/22.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards : Array<Card>
    
    private(set) var tryCount = 0;
    
    private var indexOfFaceUpCard : Int? {
        get { cards.indices.filter({ cards[$0].isFaceUp }).firstOrEmpty }
        set { cards.indices.forEach({
            cards[$0].isFaceUp = ($0 == newValue)
        }) }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true;
                    cards[potentialMatchIndex].isMatched = true;
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                tryCount += 1;
                indexOfFaceUpCard = chosenIndex
            }
        }
    }
    
    init(numberOfPairsOfCards: Int, createCardContent : (Int) -> CardContent){
        cards = []
        
        for index in 0..<numberOfPairsOfCards {
            let content = createCardContent(index)
            cards.append(Card(id: index * 2, content: content))
            cards.append(Card(id: index * 2 + 1, content: content))
        }
        
        cards = cards.shuffled()
        //add numberOfPairsOfCards x 2 to cards array
    }
    
    struct Card : Identifiable {
        let id: Int
        var isFaceUp = false
        var isMatched = false
        let content : CardContent
    }
}

extension Array {
    var firstOrEmpty : Element? {
        self.count == 1 ? first : nil
    }
}
