//
//  File.swift
//  Game
//
//  Created by angel zambrano on 8/24/21.
//

import Foundation

// TODO: FIX
// Look for some of the bugs
// kinda lazy to look
class Memorize {
    
    var rounds: Int = 0
    ///
    var currentRound: Int = 1
    /// the amount of shapes remembered
    var shapesRembered: Int = 0;
    /// the description being shown to the user
    var desc = "Play a game"
    private var gameHasStarter = false
    /// the shapes randomly chosen
    var compGenshapes = [shape]()
    /// the shapes the user pressed
    var userChosenShapes = [shape]()
    
    init(rounds: Int) {
        self.rounds = rounds
    }
    
    init() { }

    func reset() {
            currentRound = 1
            shapesRembered = 0
            compGenshapes.removeAll() // remove all of the dates
            userChosenShapes.removeAll() // remove all of the arrays
            desc = "Play a game"
    }

    
    func startGame() {
        // initialize the shapes
        let shpes = shape.getShapes()
        // you get the shapes from the user
        for _ in 0..<rounds {
            let randomInt = Int(arc4random_uniform(4))
            compGenshapes.append(shpes[randomInt])
        }
       // shuffles the array
        compGenshapes.shuffle()
    }
    
    
    func enter(shape: shape) {
        if userChosenShapes.count < rounds {
            userChosenShapes.append(shape)
            currentRound += 1
        } else{
            print("you cannot add more cards")
        }
        
        print(currentRound)
    }
    
    func endGame() {
        
        if rounds == userChosenShapes.count {
            for i in 0..<userChosenShapes.count {
                for j in 0..<compGenshapes.count {
                    if userChosenShapes[i] == compGenshapes[j] && (i == j) {
                        shapesRembered += 1
                    }
                }
            }
            desc = getDescription()
        } else {
            print("error: they need to be the same")
        }
    }
    
    func getRandomShapes() -> [shape] {
        return compGenshapes
    }
    
    private func getDescription() -> String {
        return "You remembered \(shapesRembered) out of \(rounds)"
    }
    
}

enum shape: Comparable {
    case square
    case circle
    case triangle
    case star
    
   static func getShapes() -> [shape] {
        return [.square,.circle, .triangle, .star ]
    }
    
}

