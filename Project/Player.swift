//
//  Player.swift
//  Project
//
//  Created by Raasa on 27/11/22.
//

import Foundation

protocol Player{
    var tokens: Set<Token> { get set }
    
    func rollDice() -> Int
    func canMove(token: Token) -> Bool
    func move(token: Token)
    func kill(token: Token)
}

class Human:Player{
    
    var id:String
    var name:String
    var tokens: Set<Token> = Set<Token>()
    
    init(id:String, name: String){
        self.id = id
        self.name = name
        self.initializeTokens()
    }
    
    func initializeTokens(){
        tokens.removeAll()
        
        tokens.insert(Token(id:self.id+"1", x:0,y:0,color: "yellow",img: "yellow"))
        tokens.insert(Token(id:self.id+"2", x:0,y:1,color: "yellow",img: "yellow"))
        tokens.insert(Token(id:self.id+"3", x:1,y:0,color: "yellow",img: "yellow"))
        tokens.insert(Token(id:self.id+"4", x:1,y:1,color: "yellow",img: "yellow"))
    }
    
    func rollDice() -> Int {
        return Int.random(in: 1...6)
    }
    
    func canMove(token: Token) -> Bool {
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
    var color:String
    var tokens: Set<Token> = Set<Token>()
    
    init(id:String, name: String, color:String){
        self.id = id
        self.name = name
        self.color = color
    }
    
    func rollDice() -> Int {
        return Int.random(in: 1...6)
    }
    
    func canMove(token: Token) -> Bool {
        return true;
    }
    
    func move(token: Token) {
        return;
    }
    
    func kill(token: Token) {
        return;
    }
    
    
}
