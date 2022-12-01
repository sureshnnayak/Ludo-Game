 //
//  Layout.swift
//  Project
//
//  Created by Suresh Narasimha Nayak on 11/27/22.
//

import UIKit

struct Cell{
    var id: String
    var color: Int
    var nextCell: [String]
    var safe: Bool
}



class Layout{
    let ratio: CGFloat = 0.9
    var origionX: CGFloat = -10
    var origionY: CGFloat = -10
    var cellSide: CGFloat =  10
    var players : [Player] = []
    var arr = Array(repeating: Array(repeating: Cell.self, count: 2), count: 3)
    

    init(cellSide:CGFloat, origionX: CGFloat, origionY: CGFloat ){
        self.origionX = origionX
        self.origionY = origionY
        self.cellSide = cellSide
//        var human1:Human = Human(id: "P1", name: "Player1", color: "yellow")
//        var human2:Human = Human(id: "P2", name: "Player2", color: "green")
//        var human3:Human = Human(id: "P3", name: "Player3", color: "blue")
//        var human4:Human = Human(id: "P4", name: "Player4", color: "red")
//        self.players.append(human2)
        self.createPlayers(type: ["Human"], colors: ["red","yellow"])
    }
    func constreuctKey(x: Int, y:Int)->String{
        return String(format: "%02d",x) + String(format: "%02d", y)
        //return "0101"
        //return : create the key (4 digits)
    }
    func populateCell( key:String)->Cell{
       // var cell : Cell = Cell(id: key, color: callMapping[key][0],nextCell: callMapping[key][1], safe: callMapping[key][2])
        //let col : Int = (callMapping[key])!
        //print("\(#function)",key, callMapping[key]![0], "\n" )
        var cell : Cell = Cell(id: key, color: Int(truncating: callMapping[key]![0] as! NSNumber),nextCell: ["0001"], safe: true)   
        return cell
        
        
    }
    func drawBoard(){
        
        var key: String
        var cell : Cell
        for i in 0...14{
            for j in 0...14{
                key = constreuctKey(x: i,y: j)
                cell = populateCell(key : key)
                switch(cell.color){
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
    
    func drawPieces(){
        
        for human in players{
            for token in human.tokens{
                let pieceImage = UIImage(named:token.imageName)
                pieceImage?.draw(in: CGRect(x: origionX + CGFloat(token.locationX) * cellSide, y: origionY + CGFloat(token.locationY) * cellSide, width: cellSide, height: cellSide))
            }
        }
        
    }
    
    func getNextCell(currentX :Int, currentY: Int, jumps: Int, player: Player ){
        
        
    }
    
    func createPlayers(type: [String], colors:[String]){
        for i in 0...(3){
            var human1:Human = Human(id: "P"+String(i), name: "Player"+String(i), color: "red")
            var human2:Human = Human(id: "P"+String(i), name: "Player"+String(i), color: "blue")
            self.players.append(human1)
            self.players.append(human2)
        }
    }

}
