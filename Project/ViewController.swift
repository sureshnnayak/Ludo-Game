//
//  ViewController.swift
//  Project
//
//  Created by Suresh Narasimha Nayak on 11/27/22.
//

import UIKit

class ViewController: UIViewController {

    let diceImage = ["one", "two", "three", "four", "five", "six"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        dice.image = UIImage(named: "five")
    }

    @IBOutlet weak var dice: UIImageView!
    
    @IBAction func rollDice(_ sender: Any) {
        dice.image = UIImage(named:diceImage[Int(arc4random_uniform(6))] )
    }

}

