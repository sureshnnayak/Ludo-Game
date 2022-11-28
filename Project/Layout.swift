//
//  Layout.swift
//  Project
//
//  Created by Suresh Narasimha Nayak on 11/27/22.
//

import UIKit

class Layout{
    let ratio: CGFloat = 0.9
    var origionX: CGFloat = -10
    var origionY: CGFloat = -10
    var cellSide: CGFloat =  10

    init(cellSide:CGFloat, origionX: CGFloat, origionY: CGFloat ){
        self.origionX = origionX
        self.origionY = origionY
        self.cellSide = cellSide
    }
    
    func drawBoard(){
        
        
        for i in 0...14{
            for j in 0...14{
                if (i+j)%2 == 0{
                    drawSquare(col:j, row: i, color: UIColor.yellow)
                }
                else{
                    drawSquare(col: j, row: i, color: UIColor.green)
                }
            }
        }
        
     
    }
    func drawSquare(col: Int, row: Int, color: UIColor){
        let path = UIBezierPath(rect: CGRect(x: origionX + CGFloat(col) * cellSide, y: origionY  + CGFloat(row)*cellSide, width: cellSide, height: cellSide))
        color.setFill()
        path.fill()
    }
    
    func drawPieces(){
        let pieceImage = UIImage(named:"yellow")
        pieceImage?.draw(in: CGRect(x: origionX, y: origionY, width: cellSide, height: cellSide))
        
    }
    

}
