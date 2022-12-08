//
//  BoardView.swift
//  Project
//
//  Created by Suresh Narasimha Nayak on 11/27/22.
//

import UIKit
import Foundation

// This class is used to display the Ludo board in Ui
class BoardView: UIView , Subscriber{
    let ratio: CGFloat = 0.9
    var origionX: CGFloat = -10
    var origionY: CGFloat = -10
    var cellSide: CGFloat =  10
    var shadowPlayers : [Player] = []
    
    override func draw(_ rect: CGRect) {
   
        cellSide = bounds.width * ratio / 15
        origionY =  bounds.width * (1 - ratio) / 2
        origionX =  bounds.width * (1 - ratio) / 2
        var layout = Layout.shared
        layout.setInstance(cellSide: cellSide, origionX: origionX, origionY: origionY, ratio: ratio)
        
        layout.drawBoard()
        self.drawPieces()
     
    }
    
    //This function is used to draw the tokens
    func drawPieces(){
        
        for human in shadowPlayers{
            for token in human.tokens{
                let pieceImage = UIImage(named:token.imageName)
                let x = Int(token.location.prefix(2))!
                let y = Int(token.location.suffix(2))!
                
                pieceImage?.draw(in: CGRect(x: origionX + CGFloat(x) * cellSide, y: origionY + CGFloat(y) * cellSide, width: cellSide, height: cellSide))
            }
        }
        
    }
    
    // This function is used to get the coordinates of a users click
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let first = touches.first!
        let fingerLocation = first.location(in: self)
        var gameEngine: GameEngine = GameEngine.shared
        let fromCol : Int = Int((fingerLocation.x - origionX)/cellSide)
        let fromRow : Int = Int((fingerLocation.y - origionY)/cellSide)
        print(fromCol,fromRow)
        gameEngine.fromCol = fromCol
        gameEngine.fromRow = fromRow
    }
    
    /*
     This update function is part of Subscriber implementation
     The players are updated based on the message sent by the publisher
     */
    func update(message: String) {
        let words = message.components(separatedBy: " ")
        let length = words.count
        var messageType: String
        
        // Move message is longer than Kill message
        if (length == 6){
            messageType = "Kill"
        }
        else{
            messageType = "Move"
        }
        
        if(messageType == "Move"){
            var playerId = words[1]
            var tokenId = words[4]
            var location = words[6]
            for shadowPlayer in shadowPlayers {
                if(shadowPlayer.id == playerId){
                    for token in shadowPlayer.tokens{
                        if(token.id == tokenId){
                            token.location = location
                        }
                    }
                }
            }
        }
        else{
            var tokenId = words[2]
            var location = words[5]
            for shadowPlayer in shadowPlayers {
                for token in shadowPlayer.tokens{
                    if(token.id == tokenId){
                        token.location = location
                    }
                }
            }
        }
    }
}
