//
//  Player.swift
//  Project
//
//  Created by Raasa on 27/11/22.
//

import Foundation

//Interface that describes the main members of a player
protocol Player{
    var id:String { get set }                       // Unique player id
    var tokens: Set<Token> { get set }              // Set of 4 tokens
    var color: String  { get set }                  // Defines the players color
    var type:String { get set }                     // Tells us HHuman or Computer type player
    func canMove(token: Token, diceVal:Int) -> Bool // Check if given token can move for the given dice value
    func move(token: Token, diceVal: Int)           //Moves the given token based on the given dice value
    func kill(token: Token)                         //Finds and kills a opponents token present in same box as given token
    func playerStatus()-> Bool
}

//This class is used  to create Human Players
class Human:Player{
    
    var id:String
    var name:String
    var tokens: Set<Token> = Set<Token>()
    var color: String
    var board: [String:Cell]
    var players: [Player]
    var type:String
    
    init(id:String, name: String, color: String){
        self.id = id
        self.name = name
        self.type = "Human"
        self.color = color
        self.board = GameEngine.shared.board
        self.players = GameEngine.shared.players
        self.initializeTokens()
    }
    
    //Player's tokens are initialized
    func initializeTokens(){
        tokens.removeAll()
        let homeIds : [String] = tokenHomes[self.color]!
        
        for i in 0...3{
            tokens.insert(Token(id: self.id + String(i), homelocation: homeIds[i], color: self.color,img: self.color))
        }
    }
    // to check if a player WOn
    func playerStatus()-> Bool{
        for t in self.tokens{
            if !t.inHome{
                return false
            }
        }
        return true
    }
        
    // To check if the given token can move from its currennt location
    func canMove(token: Token, diceVal:Int) -> Bool {
        print("can move called. dice val: ", diceVal)
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
        print("Token Location: ",token.location)
        return true;
    }
    
    //This function is used to move a token from one box to another
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
    
    //This function is used to kill an opponents token present in the same box
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

//This class is used  to create Computer Players
class Computer:Player{
    
    var id:String
    var name:String
    var tokens: Set<Token> = Set<Token>()
    var color:String
    var type:String
    var board: [String:Cell] = GameEngine.shared.board
    var players: [Player] = GameEngine.shared.players
    
    init(id:String, name: String, color: String){
        self.id = id
        self.name = name
        self.color = color
        self.type = "Computer"
        self.initializeTokens()
        
    }
    
    //Player's tokens are initialized
    func initializeTokens(){
        tokens.removeAll()
        let homeIds : [String] = tokenHomes[self.color]!
        
        for i in 0...3{
            tokens.insert(Token(id:homeIds[i], homelocation: homeIds[i], color: self.color,img: self.color))
        }
    }
    // to check if a player WOn
    func playerStatus()-> Bool{
        for t in self.tokens{
            if !t.inHome{
                return false
            }
        }
        return true
        
    }
    
    // To check if the given token can move from its currennt location
    func canMove(token: Token, diceVal:Int) -> Bool {
        print("can move called")
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
        print("Token Location: ",token.location)
        return true;
    }
    
    //This function is used to move a token from one box to another
    func move(token: Token, diceVal: Int) {
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
    
    //This function is used to kill an opponents token present in the same box
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
