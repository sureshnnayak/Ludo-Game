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
    func move(token: Token, diceVal: Int)
    func kill(token: Token)
}

class Human:Player{
    
    var id:String
    var name:String
    var tokens: Set<Token> = Set<Token>()
    var color: String
    var board: [String:Cell]
    var players: [Player]
    
    init(id:String, name: String, color: String){
        self.id = id
        self.name = name
        self.color = color
        self.board = GameEngine.shared.board
        self.players = GameEngine.shared.players
        self.initializeTokens()
    }
    
    func initializeTokens(){
        tokens.removeAll()
        let homeIds : [String] = tokenHomes[self.color]!
        
        for i in 0...3{
            tokens.insert(Token(id: self.id + String(i), homelocation: homeIds[i], color: self.color,img: self.color))
        }
    }
    
    func rollDice() -> Int {
        return Int.random(in: 1...6)
    }
    
    func canMove(token: Token, diceVal:Int) -> Bool {
        if token.homeLocation == token.location{
            if diceVal != 6{
                return false
            }
        }
        
        if token.homeStretch {
            var temp:Int = diceVal
            var cell:String = token.location
            
            while(temp > 0){
                //get next cell()
                temp = temp - 1
                var cellArray:Array<String>
                cellArray = cellMapping[cell]![2] as! Array<String>
                cell = cellArray[0]
                if cell == token.finalLocation && temp != 0{
                    return false
                }
            }
        }
        return true;
    }
    
    func move(token: Token, diceVal: Int){
        var temp:Int = diceVal
        var cell:String = token.location
        var cellArray:Array<String>
        
        board[cell]?.removeToken(tokenId: token.id)
        print("token ",token.id," moved from ", cell)
        // If token is in home location
        if diceVal == 6 && token.location == token.homeLocation{
            cellArray = cellMapping[cell]![2] as! Array<String>
            cell = cellArray[0]
        }
        
        // If token is anywhere other than home location
        else{
            while(temp > 0){
                temp = temp - 1
                cellArray = cellMapping[cell]![2] as! Array<String>
                
                if cellArray.count == 2{
                    let cell2:String = cellArray[1]
                    if colorCodes[token.color] == cellMapping[cell2]![0] as! Int{
                        cell = cellArray[1]
                        token.homeStretch = true
                        continue
                    }
                }
                cell = cellArray[0]
            }
        }
        
        let row: Int = Int(cell.prefix(2)) ?? 0
        let col: Int = Int(cell.suffix(2)) ?? 0
        token.updateLocation(row:row , col: col)
        board[cell]?.addToken(tokenId: token.id)
        print(" to  ",cell )
    }
    
    func kill(token: Token){
        var location = token.location
        var otherTokens = board[location]?.tokens
        var otherTokenId = otherTokens![0]
        var othertokenPlayerId = otherTokenId.prefix(2)
        self.board = GameEngine.shared.board
        self.players = GameEngine.shared.players
        for opponentPlayer in players{
            if(opponentPlayer.id == othertokenPlayerId){
                for opptoken in opponentPlayer.tokens{
                    if(opptoken.id == otherTokenId){
                        opptoken.goToBase()
                        board[location]?.removeToken(tokenId: opptoken.id)
                        board[opptoken.location]?.addToken(tokenId: opptoken.id)
                        print(token.id, " killed ", opptoken.id, "removed from ", location, " and added to", opptoken.location)
                        print(board[location]?.tokens)
                    }
                }
            }
        }
    }
    
}

class Computer:Player{
    
    var id:String
    var name:String
    //var color:String
    var tokens: Set<Token> = Set<Token>()
    var color:String
    
    var board: [String:Cell] = GameEngine.shared.board
    var players: [Player] = GameEngine.shared.players
    
    init(id:String, name: String, color: String){
        self.id = id
        self.name = name
        self.color = color
        self.initializeTokens()
        
    }
    
    func initializeTokens(){
        tokens.removeAll()
        let homeIds : [String] = tokenHomes[self.color]!
        
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
    
    func move(token: Token, diceVal: Int) {
        var temp:Int = diceVal
        var cell:String = token.location
        var cellArray:Array<String>
        
        board[cell]?.removeToken(tokenId: token.id)
        
        // If token is in home location
        if diceVal == 6 && token.location == token.homeLocation{
            cellArray = cellMapping[cell]![2] as! Array<String>
            cell = cellArray[0]
        }
        
        // If token is anywhere other than home location
        else{
            while(temp > 0){
                temp = temp - 1
                cellArray = cellMapping[cell]![2] as! Array<String>
                
                if cellArray.count == 2{
                    let cell2:String = cellArray[1]
                    if colorCodes[token.color] == cellMapping[cell2]![0] as! Int{
                        cell = cellArray[1]
                        token.homeStretch = true
                        continue
                    }
                }
                cell = cellArray[0]
            }
        }
        
        let row: Int = Int(cell.prefix(2)) ?? 0
        let col: Int = Int(cell.suffix(2)) ?? 0
        token.updateLocation(row:row , col: col)
        board[cell]?.addToken(tokenId: token.id)
    }
    
    func kill(token: Token){
        var location = token.location
        var otherTokens = board[location]?.tokens
        var otherTokenId = otherTokens![0]
        var othertokenPlayerId = otherTokenId.prefix(2)
        for opponentPlayer in players{
            if(opponentPlayer.id == othertokenPlayerId){
                for opptoken in opponentPlayer.tokens{
                    if(opptoken.id == otherTokenId){
                        opptoken.goToBase()
                        board[location]?.removeToken(tokenId: opptoken.id)
                        board[opptoken.location]?.addToken(tokenId: opptoken.id)
                        print(token.id, " killed ", opptoken.id)
                    }
                }
            }
        }
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


