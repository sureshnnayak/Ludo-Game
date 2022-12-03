//
//  GameEngine.swift
//  Project
//
//  Created by Raasa on 01/12/22.
//

import Foundation

class GameEngine{
    var players: [Player] = []
    
    static var shared : GameEngine = GameEngine()
    
    private init(){
        
    }
    /*
     select the token based in the pyer object passed and call move on one of the token
     */
    func move(player:Player, diceVal:Int){
        for t in player.tokens{
            if player.canMove(token: t){
                moveToken(token:t, diceVal: diceVal)
                return
            }
        }
        //iterate through all the token to find and mpvable token
        
    }
    func initializePlayers(){
        var colors = ["red","yellow"]
        var player: Player
        for i in 0...(1){
//            var human:Human = Human(id: "P"+String(i), name: "Player"+String(i), color: colors[i])
//            self.players.append(human)
            player = HumanCreator().createPlayer(playerId: "P"+String(i), name: "Player"+String(i), color: colors[i])
//            //(pla: "P"+String(i), name: "Player"+String(i), color: colors[i])
            self.players.append(player)
        }
    }
    
    func moveToken(token:Token, diceVal: Int){
        var temp:Int = diceVal
        var cell:String = token.id
        print(cell)
        
        while(temp > 0){
            //get next cell()
            temp = temp - 1
            var cellArray:Array<String>
            cellArray = callMapping[cell]![2] as! Array<String>
            cell = cellArray[0]
            print("Next cell is : ", cell)
        }
        //print(cell)
        
        var row: Int = Int(cell.prefix(2)) ?? 0
        var col: Int = Int(cell.suffix(2)) ?? 0
        token.updateLocation(row:row , col: col)
        
    }
    
    
//    func moveToken (startRow: Int, startColumn: Int, endRow: Int, endCol: Int, diceValue: Int){
//        var activePlayer : Player = players[1]
////        for i in players{
////            if (i.id == player.id){
////                var activePlayer : Player = i
////                break
////            }
////        }
//        //let playingPlayer : Player = activePlayer
//        guard let candidate = tokenAt(startRow: startRow, startColumn: startColumn, player: activePlayer) else {
//            return
//        }
//        candidate.updateLocation(row: endRow, col: endCol, val:diceValue)
//    }
//
//    private func tokenAt(startRow: Int, startColumn: Int, player: Player)->Token?{
//        for token in player.tokens{
//            if (token.locationX == startRow)&&(token.locationY == startColumn){
//                return token
//            }
//        }
//        return nil
//    }
}
