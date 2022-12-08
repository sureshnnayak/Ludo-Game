 //
//  Layout.swift
//  Project
//
//  Created by Suresh Narasimha Nayak on 11/27/22.
//

import UIKit

struct Box{
    var id: String
    var color: Int
}



class Layout{
    var ratio: CGFloat = 0.9
    var origionX: CGFloat = -10
    var origionY: CGFloat = -10
    var cellSide: CGFloat =  10
    
    static var shared : Layout = Layout()
    
    private init(){
    }
    
    func setInstance(cellSide:CGFloat, origionX: CGFloat, origionY: CGFloat, ratio: CGFloat){
        self.origionX = origionX
        self.origionY = origionY
        self.cellSide = cellSide
        self.ratio = ratio
    }
    
    func constreuctKey(x: Int, y:Int)->String{
        return String(format: "%02d",x) + String(format: "%02d", y)
    }
    func populateCell( key:String)->Box{
        var box : Box = Box(id: key, color: Int(truncating: cellMapping[key]![0] as! NSNumber))
        return box
        
        
    }
    func drawBoard(){
        
        var key: String
        var box : Box
        for i in 0...14{
            for j in 0...14{
                key = constreuctKey(x: i,y: j)
                box = populateCell(key : key)
                switch(box.color){
                    /*
                     1: white
                     2: red
                     3. Blue
                     4: green
                     5: yellow
                     6. black
                     */
                case 1:
                    drawCell(col:j, row: i, color: UIColor.white)
                case 2:
                    drawCell(col:j, row: i, color: UIColor.red)
                case 3:
                    drawCell(col:j, row: i, color: UIColor.blue)
                case 4:
                    drawCell(col:j, row: i, color: UIColor.green)
                case 5:
                    drawCell(col:j, row: i, color: UIColor.yellow)
                case 6:
                    drawCell(col:j, row: i, color: UIColor.black)
                    
                default:
                    drawCell(col:j, row: i, color: UIColor.gray)
                }
            }
        }
    }
    
    func drawCell(col: Int, row: Int, color: UIColor){
        let path = UIBezierPath(rect: CGRect(x: origionX + CGFloat(col) * cellSide, y: origionY  + CGFloat(row)*cellSide, width: cellSide, height: cellSide))
        color.setFill()
        path.fill()
        
    }
}
