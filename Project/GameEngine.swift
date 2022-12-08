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
    var fromCol : Int = 0
    var fromRow : Int = 0
    static var shared : GameEngine = GameEngine() //singleton
    
    private init(){
        
    }

    /* ask user to pick the token */
    func pickToken( moveableTokens: Set<Token> , completion: @escaping (Token) -> Void){
        var entered :Bool = true
        var location = String(format: "%02d",0) + String(format: "%02d", 0)
        print("insid pick")
        //while (entered){
        print("inside while")
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [self] in
            for t in moveableTokens{
                location = String(format: "%02d",fromCol) + String(format: "%02d", fromRow)
                print("selected cell",location,t.location)
                if t.location == location{
                    entered = false
                    print("moving",location)
                    completion(t)
                }
            }
        }
    }
    
    /* select the token based in the pyer object passed and call move on one of the token */
    func move(player:Player, diceVal:Int){
        var moveableTokens: Set<Token> = Set<Token>()
        var command: Command
        
        for t in player.tokens{
            if player.canMove(token: t, diceVal: diceVal){
                moveableTokens.insert(t)
            }
        }
        if moveableTokens.count == 0{
            return
        }
        print("movable token count ",moveableTokens.count)
        var selectedToken:Token = moveableTokens.first!
        
        if(player.type == "Computer"){
            print("Computer triggered")
            command = ComputerMoveCommand(player: player as! Computer, diceVal: diceVal)
            command.execute(playingToken: selectedToken)
            if(killRequired(token: selectedToken)){
                player.kill(token: selectedToken)
            }
        }
        else{
            print("Human triggered")
            command = HumanMoveCommand(player: player as! Human, diceVal: diceVal)
            if moveableTokens.count > 1 {
                print("inside select")
                pickToken(moveableTokens: moveableTokens){ t in
                    //player.move(token: selectedToken, diceVal: diceVal)
                    selectedToken = t
                    command.execute(playingToken: selectedToken)
                    print("token selected")
                    
                }
                //command.execute(playingToken: selectedToken)
                if(killRequired(token: selectedToken)){
                    player.kill(token: selectedToken)
                }
            }
            else{
                //iterate through all the token to find and movable token
                command.execute(playingToken: selectedToken)
                
                if(killRequired(token: selectedToken)){
                    player.kill(token: selectedToken)
                }
                //moveToken(token:t, diceVal: diceVal)
            }
        }
        
        
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
            }
        }
        print("Players and tokens are initialized")
    }
    
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
}
