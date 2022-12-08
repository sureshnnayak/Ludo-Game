//
//  ViewController.swift
//  Project
//
//  Created by Suresh Narasimha Nayak on 11/27/22.
//

import UIKit

class ViewController: UIViewController{//}, LudoDelegate {
    
    var gameEngine: GameEngine = GameEngine.shared
    var diceVal: Int = 5
    var prevPlayer:Int = 0
    var gameOver:Bool = false
    
    @IBOutlet weak var dice: UIImageView!
    @IBOutlet weak var boardView: BoardView!
    
    @IBOutlet weak var textView: UITextField!
    let diceImage = ["one", "two", "three", "four", "five", "six"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameEngine.initializeGame()
        boardView.shadowPlayers = gameEngine.players
        
        dice.image = UIImage(named: "five")
        textView.text = boardView.shadowPlayers[0].id + " starts game"
    }

    @IBAction func rollDice(_ sender: Any) {
        diceVal = Int(arc4random_uniform(6)) + 1
        //diceVal = 6
        dice.image = UIImage(named:diceImage[diceVal-1])
         
        var nextPlayer: Int
        var currentPlayer: Player
        
        nextPlayer = (prevPlayer + 1 ) % boardView.shadowPlayers.count
        currentPlayer = boardView.shadowPlayers[prevPlayer]
        gameEngine.move(player: currentPlayer, diceVal: diceVal)
        textView.text = "Player " + boardView.shadowPlayers[nextPlayer].color + "'s turn"

        prevPlayer = nextPlayer
        
        //boardView.shadowPlayers = gameEngine.players
        DispatchQueue.main.asyncAfter(deadline: .now() + 5){[self] in
            boardView.setNeedsDisplay()}
    }
}
