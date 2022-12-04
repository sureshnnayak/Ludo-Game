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
    //var gameOver = false
    
    @IBOutlet weak var dice: UIImageView!
    @IBOutlet weak var boardView: BoardView!
    
    let diceImage = ["one", "two", "three", "four", "five", "six"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        gameEngine.initializePlayers()
        boardView.shadowPlayers = gameEngine.players
        //boardView.ludoDelegate = self
        dice.image = UIImage(named: "five")
        //gameEngin.Turn()
        /* to click the button automatically
         rollDice((Any).self)
         */
        //turn(number:diceVal)
        
    }
    
    /*
     func turn(number: Int){
        
        gameEngine.moveToken(startRow: 01, startColumn: 11, endRow: 06, endCol: 13, diceValue: Int(number))
        boardView.shadowPlayers = gameEngine.players
        boardView.setNeedsDisplay()
        
    }
     */

  
    
    @IBAction func rollDice(_ sender: Any) {
        //diceVal = Int(arc4random_uniform(6)) + 1
        diceVal = 6
        dice.image = UIImage(named:diceImage[diceVal-1])
         
        var nextPlayer: Int
        var currentPlayer: Player
        
        nextPlayer = (prevPlayer + 1 ) % boardView.shadowPlayers.count
        currentPlayer = boardView.shadowPlayers[nextPlayer]
        gameEngine.move(player: currentPlayer, diceVal: diceVal)
         
         //move(diceVal)
         prevPlayer = nextPlayer
//         if nextplayer is computer{
//         rollDice((Any).self)
//         }
         
         
         /*/////
         1. Ask the used which icon to move
         2. Check if iconm can be moved
         3. move the icon
         4. Trigger action on the target cell
         5
         */
        //print(diceVal)
//        while(!gameOver){
//            for player in boardView.shadowPlayers{
//                turn(number:diceVal+1)
//            }
//        }
        //turn(number:diceVal+1)
        boardView.shadowPlayers = gameEngine.players
        boardView.setNeedsDisplay()
    }
    
    /*
     func moveToken(startRow: Int, startColumn: Int, endRow: Int, endCol: Int, diceValue: Int){
        gameEngine.moveToken(startRow: startRow, startColumn: startColumn, endRow: endRow, endCol: endCol, diceValue: diceValue )
        boardView.shadowPlayers = gameEngine.players
        boardView.setNeedsDisplay()
    }
     */
}

