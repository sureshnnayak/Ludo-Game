//
//  Commands.swift
//  Project
//
//  Created by Raasa on 08/12/22.
//

import Foundation

//Command pattern is implemented here to move and kill player tokens
protocol Command{
    func execute(playingToken:Token)
}

//Human move commmand
class HumanMoveCommand:Command{
    let dice: Int
    let player: Human
    
    
    init (player: Human, diceVal:Int){
        self.dice = diceVal
        self.player = player
    }
    func execute(playingToken:Token){
        player.move(token: playingToken, diceVal: dice)
    }
}

//Human kill commmand
class HumanKillCommand:Command{
    let player: Human
    
    
    init (player: Human){
        self.player = player
    }
    func execute(playingToken:Token){
        player.kill(token: playingToken)
    }
}

//Computer move commmand
class ComputerMoveCommand:Command{
    let dice: Int
    let player: Computer
    
    
    init (player: Computer, diceVal:Int){
        self.dice = diceVal
        self.player = player
    }
    func execute(playingToken:Token){
        player.move(token: playingToken, diceVal: dice)
    }
}

//Computer kill commmand
class ComputerKillCommand:Command{
    let player: Computer
    
    
    init (player: Computer){
        self.player = player
    }
    func execute(playingToken:Token){
        player.kill(token: playingToken)
    }
}
