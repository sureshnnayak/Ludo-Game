#  TODO
1. connect the cells
2. trigger move upon dice roll
    2.1 add a global varibale in view Controller
    2.2 have an array of player objects
    2.3 In move iterate over tokens to check which can be moved
        move the forst token <<>>
        
3. 

    func kill(token: Token){
        var location = token.location
        var otherTokenId = board[location]?.tokens[0]
        var othertokenPlayerId = otherTokenId!.prefix(2)
        if( othertokenPlayerId != token.id.prefix(2)){
            print("Opponent token present")
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
    
    func killRequired(token: Token)-> Bool{
        let location = token.location
        let otherTokens = board[location]?.tokens
        if(otherTokens!.count>1){
            if(board[location]?.safe == false){
                print("Kill required")
                return true
            }
        }
        print("No kill required")
        return false
    }
