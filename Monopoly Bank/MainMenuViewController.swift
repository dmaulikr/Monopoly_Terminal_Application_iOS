//
//  MainMenuViewController.swift
//  Monopoly Bank
//
//  Created by HASH on 7/16/16.
//  Copyright © 2016 HashimJawad. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {
    
    @IBOutlet weak var gameSess: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var cardImage: UIImageView!
    var cards = [UIImage(named: "card1"),UIImage(named: "card2"),UIImage(named: "card3"),UIImage(named: "card4"),UIImage(named: "card5"),UIImage(named: "card6")]
    
    var counter = 0
    var card1 = false
    var card2 = false
    var card3 = false
    var card4 = false
    var card5 = false
    var card6 = false
    
    var selectedCard: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func changeCardRight(sender: UIButton) {
        goRightThroughCards()
    }
    
    @IBAction func changeCardLeft(sender: UIButton) {
        goLeftThroughCards()
    }
    
    func goRightThroughCards() {
        
        if self.counter > 5 {
            self.counter = 5
        }
        else if self.counter < 0 {
            self.counter = 0
        }
        else
        {
            cardImage.image = cards[self.counter]
            self.counter = self.counter + 1
        }
        checkWhichCardIsOnTheScreen()
        
    }
    
    func goLeftThroughCards() {
        
        if self.counter < 0  {
            self.counter = 0
        }
        else if self.counter > 5 {
            self.counter = 5
        }
        else
        {
            cardImage.image = cards[self.counter]
            self.counter = self.counter - 1
        }
        
        checkWhichCardIsOnTheScreen()
        
    }
    
    func checkWhichCardIsOnTheScreen() {
        
        if cardImage.image == UIImage(named: "card1") {
            card1 = true
            card2 = false
            card3 = false
            card4 = false
            card5 = false
            card6 = false
            print("card1")
        } else if (cardImage.image == UIImage(named: "card2")) {
            card1 = false
            card2 = true
            card3 = false
            card4 = false
            card5 = false
            card6 = false
            print("card2")
        } else if (cardImage.image == UIImage(named: "card3")) {
            card1 = false
            card2 = false
            card3 = true
            card4 = false
            card5 = false
            card6 = false
            print("card3")
        } else if (cardImage.image == UIImage(named: "card4")) {
            card1 = false
            card2 = false
            card3 = false
            card4 = true
            card5 = false
            card6 = false
            print("card4")
        } else if (cardImage.image == UIImage(named: "card5")) {
            card1 = false
            card2 = false
            card3 = false
            card4 = false
            card5 = true
            card6 = false
            print("card5")
        } else if (cardImage.image == UIImage(named: "card6")) {
            card1 = false
            card2 = false
            card3 = false
            card4 = false
            card5 = false
            card6 = true
        }
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
        
    }
    
    func displayError(msg:String) {
        let alert = UIAlertController(title: "ERROR", message: msg, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "CalculatorScreen" {
            if let destination = segue.destinationViewController as? FirstViewController {
                if (card1 == true) {
                    selectedCard = "BlueCard"
                } else if (card2 == true) {
                    selectedCard = "GreenCard"
                } else if (card3 == true) {
                    selectedCard = "RedCard"
                } else if (card4 == true) {
                    selectedCard = "PurpleCard"
                } else if (card5 == true) {
                    selectedCard = "OrangeCard"
                } else if (card6 == true) {
                    selectedCard = "YellowCard"
                } else {
                    displayError("ERROR: Please choose your card.")
                }
                
                if gameSess.text != nil && !(gameSess.text?.isEmpty)! {
                    print("Ok")
                }
                else
                {
                    displayError("ERROR: The session field cannot be empty.")
                }
                
                if password.text != nil && !(password.text?.isEmpty)! {
                    if password.text?.characters.count > 10{
                        displayError("ERROR: The password should be less than 10 characters.")
                    }
                }
                else
                {
                    displayError("ERROR: Please enter a password.")

                }
                
                destination.pass = password.text
                
                destination.cardChosen = selectedCard
                destination.sessionName = gameSess.text
                


                self.presentViewController(destination, animated: true, completion: nil)
            }
        }
    }
    
}


