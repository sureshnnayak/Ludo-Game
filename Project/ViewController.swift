//
//  ViewController.swift
//  Project
//
//  Created by Suresh Narasimha Nayak on 11/27/22.
//

import UIKit

class ViewController: UIViewController {
    
    var human:Human = Human(id: "P1", name: "Player1")
    
    @IBOutlet weak var dice: UIImageView!
    @IBOutlet weak var boardView: BoardView!
    
    let diceImage = ["one", "two", "three", "four", "five", "six"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        human.initializeTokens()
        boardView.layout.human.tokens = human.tokens
        
        dice.image = UIImage(named: "five")
    }

  
    
    @IBAction func rollDice(_ sender: Any) {
        dice.image = UIImage(named:diceImage[Int(arc4random_uniform(6))] )
    }

}

