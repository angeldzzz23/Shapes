//
//  File.swift
//  Game
//
//  Created by angel zambrano on 8/24/21.
//

import Foundation


class Memorize {
    
    // MARK: Properties
    var totalRounds: Int = 0
    
    var currentRound: Int = 1
    /// the amount of shapes remembered
    private var shapesRembered: Int = 0;
    /// the description of the status of the game
    /// if no game has been played, then we use our default play a game description
    var gameDescription = "Play a game"
    /// the shapes randomly chosen
    var compGenshapes = [shape]()
    /// the shapes the user pressed
    var userChosenShapes = [shape]()
    
    
    // MARK: initializers
    init(rounds: Int) {
        self.totalRounds = rounds
    }
    
    init() { }

    
    // MARK: Important methods
    
    /// this resests the entirety of the game
    func reset() {
        currentRound = 1
        shapesRembered = 0
        compGenshapes.removeAll() // remove all of the dates
        userChosenShapes.removeAll() // remove all of the arrays
        gameDescription = "Play a game"
    }

    
    func startGame() {
        // gets all of the shapes
        let shpes = shape.getShapes()
        // you get the shapes from the user
        for _ in 0..<totalRounds {
            let randomInt = Int(arc4random_uniform(4))
            compGenshapes.append(shpes[randomInt])
        }
        
       // shuffles the array
        compGenshapes.shuffle()
    }
    
    // enters a new shape by the user
    func enter(shape: shape) {
        
        if userChosenShapes.count < totalRounds {
            userChosenShapes.append(shape)
            currentRound += 1
        } else{
            print("you cannot add more cards")
            exit(-1)
        }
    }
    
    // finalizes the end of the game by getting the total matches of the user
    func endGame() {
        if totalRounds == userChosenShapes.count {
            // check how many matches the user obtained
            for i in 0..<userChosenShapes.count {
                for j in 0..<compGenshapes.count {
                    if userChosenShapes[i] == compGenshapes[j] && (i == j) {
                        shapesRembered += 1
                    }
                }
            }
            // gets the final game description
            gameDescription = getDescription()
        } else {
            print("error: they need to be the same")
        }
    }
    
    func getRandomShapes() -> [shape] {
        return compGenshapes
    }
    
    
    private func getDescription() -> String {
        return "You remembered \(shapesRembered) out of \(totalRounds)"
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

