//
//  Player.swift
//  Project
//
//  Created by Raasa on 27/11/22.
//

import Foundation

protocol Player{
    var id:String { get set }
    var tokens: Set<Token> { get set }
    var color: String  { get set }
    func rollDice() -> Int
    func canMove(token: Token, diceVal:Int) -> Bool // take Dice input
    func move(token: Token)
    func kill(token: Token)
}

class Human:Player{
    
    var id:String
    var name:String
    var tokens: Set<Token> = Set<Token>()
    var color: String
    
    init(id:String, name: String, color: String){
        self.id = id
        self.name = name
        self.color = color
        self.initializeTokens()
    }
    
    func initializeTokens(){
        tokens.removeAll()
        var homeIds : [String] = tokenHomes[self.color]!
        
        for i in 0...3{
            tokens.insert(Token(id:homeIds[i], homelocation: homeIds[i], color: self.color,img: self.color))
        }
    }
    
    func rollDice() -> Int {
        return Int.random(in: 1...6)
    }
    
    func canMove(token: Token, diceVal:Int) -> Bool {
        //if token.homeLocation 
        return true;
    }
    
    func move(token: Token) {
        return;
    }
    
    func kill(token: Token) {
        return;
    }
    
}

class Computer:Player{
    
    var id:String
    var name:String
    //var color:String
    var tokens: Set<Token> = Set<Token>()
    var color:String
    
    init(id:String, name: String, color: String){
        self.id = id
        self.name = name
        self.color = color
        self.initializeTokens()
        
    }
    
    func initializeTokens(){
        tokens.removeAll()
        var homeIds : [String] = tokenHomes[self.color]!
        
        for i in 0...3{
            tokens.insert(Token(id:homeIds[i], homelocation: homeIds[i], color: self.color,img: self.color))
        }
    }
    
    func rollDice() -> Int {
        return Int.random(in: 1...6)
    }
    
    func canMove(token: Token, diceVal:Int) -> Bool {
        return true;
    }
    
    func move(token: Token) {
        return;
    }
    
    func kill(token: Token) {
        return;
    }
    
    
}

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


