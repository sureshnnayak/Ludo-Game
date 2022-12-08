//
//  BoardView.swift
//  Project
//
//  Created by Suresh Narasimha Nayak on 11/27/22.
//

import UIKit
import Foundation

class BoardView: UIView {
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
}
