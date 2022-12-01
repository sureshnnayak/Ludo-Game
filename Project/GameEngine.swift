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
    
    func moveToken (startRow: Int, startColumn: Int, endRow: Int, endCol: Int, diceValue: Int){
        var activePlayer : Player = players[1]
//        for i in players{
//            if (i.id == player.id){
//                var activePlayer : Player = i
//                break
//            }
//        }
        //let playingPlayer : Player = activePlayer
        guard let candidate = tokenAt(startRow: startRow, startColumn: startColumn, player: activePlayer) else {
            return
        }
        candidate.updateLocation(row: endRow, col: endCol, val:diceValue)
    }
    
    private func tokenAt(startRow: Int, startColumn: Int, player: Player)->Token?{
        for token in player.tokens{
            if (token.locationX == startRow)&&(token.locationY == startColumn){
                return token
            }
        }
        return nil
    }
}
