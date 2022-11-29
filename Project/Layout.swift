 //
//  Layout.swift
//  Project
//
//  Created by Suresh Narasimha Nayak on 11/27/22.
//

import UIKit

struct call{
    var id: Int
    var color: Int
    var nextCell: [Int]
    var safe: Bool
}



class Layout{
    let ratio: CGFloat = 0.9
    var origionX: CGFloat = -10
    var origionY: CGFloat = -10
    var cellSide: CGFloat =  10
    
    var human:Human = Human(id: "P1", name: "Player1")
    var players = [Player]()

    init(cellSide:CGFloat, origionX: CGFloat, origionY: CGFloat ){
        self.origionX = origionX
        self.origionY = origionY
        self.cellSide = cellSide
    }
    
    func drawBoard(){
        
        
        for i in 0...14{
            for j in 0...14{
                if (i+j)%2 == 0{
                    drawCell(col:j, row: i, color: UIColor.yellow)
                }
                else{
                    drawCell(col: j, row: i, color: UIColor.green)
                }
            }
        }
        
     
    }
    func drawCell(col: Int, row: Int, color: UIColor){
        let path = UIBezierPath(rect: CGRect(x: origionX + CGFloat(col) * cellSide, y: origionY  + CGFloat(row)*cellSide, width: cellSide, height: cellSide))
        color.setFill()
        path.fill()
    }
    
    func drawPieces(){
        
        for token in human.tokens{
            let pieceImage = UIImage(named:token.imageName)
            pieceImage?.draw(in: CGRect(x: origionX + CGFloat(token.locationX) * cellSide, y: origionY + CGFloat(token.locationY) * cellSide, width: cellSide, height: cellSide))
        }
        
    }
    
    func getNextCell(currentX :Int, currentY: Int, jumps: Int, player: Player ){
        
        
    }
    

}
