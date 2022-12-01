//
//  BoardView.swift
//  Project
//
//  Created by Suresh Narasimha Nayak on 11/27/22.
//

import UIKit

class BoardView: UIView {
    let ratio: CGFloat = 0.9
    var origionX: CGFloat = -10
    var origionY: CGFloat = -10
    var cellSide: CGFloat =  10
    //var layout: Layout = Layout(cellSide: 0, origionX: 0, origionY: 0, ratio: 0)
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
                pieceImage?.draw(in: CGRect(x: origionX + CGFloat(token.locationX) * cellSide, y: origionY + CGFloat(token.locationY) * cellSide, width: cellSide, height: cellSide))
            }
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let first = touches.first!
        let fingerLocation = first.location(in: self)
        
        let fromCol : Int = Int((fingerLocation.x - origionX)/cellSide)
        let fromRow : Int = Int((fingerLocation.y - origionY)/cellSide)
        print(fromCol,fromRow)
    }
    
    
//    func drawBoard(){
//        for i in 0...14{
//            for j in 0...14{
//                if (i+j)%2 == 0{
//                    drawSquare(col:j, row: i, color: UIColor.yellow)
//                }
//                else{
//                    drawSquare(col: j, row: i, color: UIColor.green)
//                }
//            }
//        }
//
//
//    }
//    func drawSquare(col: Int, row: Int, color: UIColor){
//        let path = UIBezierPath(rect: CGRect(x: origionX + CGFloat(col) * cellSide, y: origionY  + CGFloat(row)*cellSide, width: cellSide, height: cellSide))
//        color.setFill()
//        path.fill()
//    }

}
