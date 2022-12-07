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
    
    
//    let block: (Int) -> Void = { total in
//       print(“Sum of the first 1000 number is \(total)”)
//    }
    /*
     ask user to pick the token
     */
    func pickToken(completionHandler: (Int) -> Void){
        var entered :Bool = true
        while (entered){
            // cell values and compare it with the token.location values
        }
        
    }
    /*
     select the token based in the pyer object passed and call move on one of the token
     */
    func move(player:Player, diceVal:Int){
        var moveableTokens: Set<Token> = Set<Token>()
        
        for t in player.tokens{
            if player.canMove(token: t, diceVal: diceVal){
                moveableTokens.insert(t)
                //moveToken(token:t, diceVal: diceVal)
            }
        }
        //pickToken()
        //iterate through all the token to find and mpvable token
        //player.move(token: t, diceVal: diceVal)
        if(killRequired(token: t)){
            player.kill(token: t)
        }
        //moveToken(token:t, diceVal: diceVal)
        return
    }
    
    func initializeGame(){
        initializeBoard()
        initializePlayers()
    }
    
    func initializeBoard(){
        for cellKey in cellMapping.keys{
            let cellDetails = cellMapping[cellKey]
            let isSafe = (cellDetails![1] as! Int == 0 ? true : false)
            let cell = Cell(id: cellKey, color: cellDetails?[0] as! Int, nextCells: cellDetails?[2] as! [String], safe: isSafe)
            board[cellKey] = cell
        }
        print(board.count)
    }
    
    func initializePlayers(){
        let colors = ["yellow","blue","red","green"]
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
                //print(test.tokens)
            }
        //print("before adding" , cell, board[cell]?.tokens)
        board[cell]?.addToken(tokenId: token.id)
        //print("After adding" , cell, board[cell]?.tokens)
        if cell == token.finalLocation{
            token.inHome = true
        }
        var row: Int = Int(cell.prefix(2)) ?? 0
        var col: Int = Int(cell.suffix(2)) ?? 0
        token.updateLocation(row:row , col: col)
        kill(token: token)
    }
    
//    func moveToken(token:Token, diceVal: Int){
//        var temp:Int = diceVal
//        var cell:String = token.location
//        var prevCell: String = ""
//        var cellArray:Array<String>
//
//        //print("before removing" , cell, board[cell]?.tokens)
//        board[cell]?.removeToken(tokenId: token.id)
//        //print("After removing" , cell, board[cell]?.tokens)
//
//        // home location
//        if diceVal == 6 && token.location == token.homeLocation{
//            cellArray = cellMapping[cell]![2] as! Array<String>
//            cell = cellArray[0]
//        }
//
//        //not in home
//        else{
//            while(temp > 0){
//                //get next cell()
//                temp = temp - 1
//                cellArray = cellMapping[cell]![2] as! Array<String>
//
//                if cellArray.count == 2{
//                    var cell2:String = cellArray[1]
//                    if colorCodes[token.color] == cellMapping[cell2]![0] as! Int{
//                        cell = cellArray[1]
//                        continue
//                    }
//
//                }
//                prevCell = cell
//                cell = cellArray[0]
//
//
//                print("Next cell is : ", cell)
//            }
//
//        }
//
//        if(prevCell == cell){
//            board[token.location]?.addToken(tokenId: token.id)
//            return
//        }
//        //print("before adding" , cell, board[cell]?.tokens)
//        board[cell]?.addToken(tokenId: token.id)
//        //print("After adding" , cell, board[cell]?.tokens)
//
//        var row: Int = Int(cell.prefix(2)) ?? 0
//        var col: Int = Int(cell.suffix(2)) ?? 0
//        token.updateLocation(row:row , col: col)
//
//        if(killRequired(token: token)==false){
//            return
//        }
//        kill(token: token)
//    }
    
//    func kill(token: Token){
//        var location = token.location
//        var otherTokens = board[location]?.tokens
//        var otherTokenId = otherTokens![0]
//        var othertokenPlayerId = otherTokenId.prefix(2)
//        for opponentPlayer in players{
//            if(opponentPlayer.id == othertokenPlayerId){
//                for opptoken in opponentPlayer.tokens{
//                    if(opptoken.id == otherTokenId){
//                        opptoken.goToBase()
//                        print(token.id, " killed ", opptoken.id)
//                    }
//                }
//            }
//        }
//    }
    func killRequired(token: Token)->Bool{
        let location = token.location
        let otherTokens = board[location]?.tokens
        if(otherTokens!.count>1){
            let otherTokenId = otherTokens![0]
            let othertokenPlayerId = otherTokenId.prefix(2)
            if( othertokenPlayerId != token.id.prefix(2)){
                print("Opponet token in loaction")
                if(!board[location]!.safe){
                    return true
                }
                print("Safe loaction")
            }
        }
        return false
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
