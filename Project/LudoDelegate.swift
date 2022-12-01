//
//  LudoDelegate.swift
//  Project
//
//  Created by Raasa on 01/12/22.
//

import Foundation

protocol LudoDelegate {
    func moveToken(startRow: Int, startColumn: Int, endRow: Int, endCol: Int, diceValue: Int)
}
