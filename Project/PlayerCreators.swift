//
//  PlayerCreators.swift
//  Project
//
//  Created by Raasa on 08/12/22.
//

import Foundation

protocol PlayerCreator{
    func createPlayer(playerId:String, name:String, color: String)->Player;
}

class HumanCreator:PlayerCreator{
    func createPlayer(playerId:String, name:String, color: String)->Player{
        return Human(id:playerId , name: name, color: color)
    }
}

class ComputerCreator:PlayerCreator{
    func createPlayer(playerId:String, name:String, color: String)->Player{
        return Computer(id:playerId , name: name, color: color)
    }
}
