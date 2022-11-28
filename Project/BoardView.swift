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


    override func draw(_ rect: CGRect) {
   
        cellSide = bounds.width * ratio / 15
        origionY =  bounds.width * (1 - ratio) / 2
        origionX =  bounds.width * (1 - ratio) / 2
        var layout: Layout = Layout(cellSide: cellSide, origionX: origionX, origionY: origionY)
        layout.drawBoard()
        layout.drawPieces()
     
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
