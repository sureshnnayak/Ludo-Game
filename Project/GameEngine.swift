//
//  GameEngine.swift
//  Project
//
//  Created by Raasa on 01/12/22.
//

import Foundation

class GameEngine{
    var players: [Player] = []
    var board = [String:Cell]()
    
    static var shared : GameEngine = GameEngine()
    
    private init(){
        
    }
    /*
     select the token based in the pyer object passed and call move on one of the token
     */
    func move(player:Player, diceVal:Int){
        
        for t in player.tokens{
            if player.canMove(token: t, diceVal: diceVal){
                moveToken(token:t, diceVal: diceVal)
                return
            }
        }
        //iterate through all the token to find and mpvable token
        
    }
    
    func initializeGame(){
        initializeBoard()
        initializePlayers()
    }
    
    func initializeBoard(){
        for cellKey in cellMapping.keys{
            let cellDetails = cellMapping[cellKey]
            let isSafe = (cellDetails![1] as! Int == 1 ? true : false)
            let cell = Cell(id: cellKey, color: cellDetails?[0] as! Int, nextCells: cellDetails?[2] as! [String], safe: isSafe)
            board[cellKey] = cell
        }
        print(board.count)
    }
    
    func initializePlayers(){
        let colors = ["green","yellow","blue","red"]
        var player: Player
        for i in 0...(colors.count-1){
//            var human:Human = Human(id: "P"+String(i), name: "Player"+String(i), color: colors[i])
//            self.players.append(human)
            player = HumanCreator().createPlayer(playerId: "P"+String(i), name: "Player"+String(i), color: colors[i])
            self.players.append(player)
        }
        for player in players{
            for userToken in player.tokens{
                let location = userToken.location
                let test: Cell = board[location]!
                test.addToken(tokenId: userToken.id)
                print(test.tokens)
            }
        }
    }
    
    func moveToken(token:Token, diceVal: Int){
        var temp:Int = diceVal
        var cell:String = token.location
        var cellArray:Array<String>
        
        //print("before removing" , cell, board[cell]?.tokens)
        board[cell]?.removeToken(tokenId: token.id)
        //print("After removing" , cell, board[cell]?.tokens)
        
        // home location
        if diceVal == 6 && token.location == token.homeLocation{
            cellArray = cellMapping[cell]![2] as! Array<String>
            cell = cellArray[0]
        }
        
        //not in home
        else{
            while(temp > 0){
                //get next cell()
                temp = temp - 1
                cellArray = cellMapping[cell]![2] as! Array<String>
                
                if cellArray.count == 2{
                    var cell2:String = cellArray[1]
                    if colorCodes[token.color] == cellMapping[cell2]![0] as! Int{
                        cell = cellArray[1]
                        continue
                    }
                    
                }
                cell = cellArray[0]
                
                
                print("Next cell is : ", cell)
            }
        
        }
        //print("before adding" , cell, board[cell]?.tokens)
        board[cell]?.addToken(tokenId: token.id)
        //print("After adding" , cell, board[cell]?.tokens)
        
        var row: Int = Int(cell.prefix(2)) ?? 0
        var col: Int = Int(cell.suffix(2)) ?? 0
        token.updateLocation(row:row , col: col)
        kill(token: token)
    }
    
    func kill(token: Token){
        var location = token.location
        var otherTokens = board[location]?.tokens
        if(otherTokens!.count>1){
            print("triggered1")
            print(otherTokens!.count)
            var otherTokenId = otherTokens![0]
            var othertokenPlayerId = otherTokenId.prefix(2)
            if( othertokenPlayerId != token.id.prefix(2)){
                print("triggered2")
                for opponentPlayer in players{
                    if(opponentPlayer.id == othertokenPlayerId){
                        print("triggered3")
                        for opptoken in opponentPlayer.tokens{
                            if(opptoken.id == otherTokenId){
                                print("triggered4")
                                opptoken.goToBase()
                                print(token.id, " killed ", opptoken.id)
                                
                            }
                        }
                    }
                }
            }
        }
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
