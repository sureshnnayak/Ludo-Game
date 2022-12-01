//
//  Tokens.swift
//  Project
//
//  Created by Suresh Narasimha Nayak on 11/27/22.
//

import Foundation

class Token:Hashable{
     
     public var id:String
     public var color:String
     public var locationX: Int
     public var locationY: Int
     private var inHome: BooleanLiteralType
     private var inBase: BooleanLiteralType
     public let imageName: String
    
     public var homeLocationX: Int
     public var homeLocationY: Int
     
    init(id:String, x: Int, y:Int, color:String, img:String){
         self.id = id
         self.locationX = x
         self.locationY = y
         self.homeLocationX = x
         self.homeLocationY = y
         self.color = color
         self.inHome = false
         self.inBase = true
         self.imageName = img
     }
    
     public func isTokeninPlay() -> Bool{
         if(self.inHome || self.inBase){
             return false
        }
        return true;
    }
    
    static func == (lhs: Token, rhs: Token) -> Bool {
        if lhs.id == rhs.id{
            return true
        }
        return false
    }
    
    public var hashValue: Int {
        return id.hashValue
    }
 }
 
