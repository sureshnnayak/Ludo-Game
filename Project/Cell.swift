//
//  Cell.swift
//  Project
//
//  Created by Raasa on 03/12/22.
//

import Foundation

//This class holds the properties of cells in the LudoBoard
class Cell: Hashable{
    
    var id: String
    var color: Int
    var nextCells: [String]
    var safe: Bool
    var tokens: [String]

    init(id:String, color: Int, nextCells:[String], safe:Bool){
        self.id = id
        self.color = color
        self.nextCells = nextCells
        self.safe = safe
        self.tokens = [String]()
    }
    
    static func == (lhs: Cell, rhs: Cell) -> Bool {
        if((lhs.id == rhs.id)){
            return true
        }
        return false
    }
    
    public var hashValue: Int {
        return Int(id.hashValue)
    }
    
    func addToken(tokenId: String){
        self.tokens.append(tokenId)
    }
    
    func removeToken(tokenId: String){
        self.tokens.remove(at: 0)
    }
}
