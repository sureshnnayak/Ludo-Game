//
//  GameEngine.swift
//  Project
//
//  Created by Raasa on 01/12/22.
//

import Foundation

class GameEngine{
    var players: [Player] = []
    
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
    
    func moveToken(startRow: Int, startColumn: Int, diceValue: Int){
        
    }
}
