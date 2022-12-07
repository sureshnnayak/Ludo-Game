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
    public var location: String
    //public var locationY: Int
    public var inHome: BooleanLiteralType
    public var inBase: BooleanLiteralType
    public let imageName: String
    public var homeLocation: String
    public var homeStretch: Bool
    public var finalLocation: String
     //public var homeLocationY: Int
     
    init(id:String, homelocation : String, color:String, img:String){
        self.id = id
        self.location = homelocation
        //self.locationY = y
        self.homeLocation = homelocation
        //self.homeLocationY = y
        self.color = color
        self.inHome = false
        self.inBase = true
        self.imageName = img
        self.homeStretch = false
        self.finalLocation = finalLocations[color]!
        //self.finalLocation = homelocation // Need to change
     }
    
    /*
     return true if the token is not in home or starting position
     */
     public func isTokeninPlay() -> Bool{
         if(self.inHome || self.inBase){
             return false
        }
        return true;
    }
    
    
    public func updateLocation(row: Int, col: Int){
//        if (self.inBase == true){
//                return removeFromBase(row: row, col: col, val:val)
//        }
        //self.locationX = row
        //self.locationY = col
        self.location = String(format: "%02d",row) + String(format: "%02d", col)
        //self.id = String(format: "%02d",row) + String(format: "%02d", col)  // need to update
        if (self.location != self.homeLocation){
            self.inBase = false
        }
        if (self.location == self.finalLocation){
            self.inHome = true
        }
    }
    
    /* Update the location to starting location
     */
    public func goToBase(){
        self.location = self.homeLocation
        self.inBase = true
    }
    
//    func removeFromBase(row: Int, col: Int, val:Int){
//        if (val != 6){
//            return
//        }
//        self.locationX = row
//        self.locationY = col
//        self.inBase = false
//    }
    
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
 
