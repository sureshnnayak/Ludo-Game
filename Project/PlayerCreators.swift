//
//  PlayerCreators.swift
//  Project
//
//  Created by Raasa on 08/12/22.
//

import Foundation

//Factory pattern is implemented here to create different types of players
protocol PlayerCreator{
    func createPlayer(playerId:String, name:String, color: String)->Player;
}

//Used to create Human players
class HumanCreator:PlayerCreator{
    func createPlayer(playerId:String, name:String, color: String)->Player{
        return Human(id:playerId , name: name, color: color)
    }
}

//Used to create Computer players
class ComputerCreator:PlayerCreator{
    func createPlayer(playerId:String, name:String, color: String)->Player{
        return Computer(id:playerId , name: name, color: color)
    }
}
