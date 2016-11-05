//
//  SecondViewController.swift
//  Monopoly Bank
//
//  Created by HASH on 7/13/16.
//  Copyright © 2016 HashimJawad. All rights reserved.
//

import UIKit

protocol SecondViewControllerDelegate {
    func acceptData(firstBalance: String!,secondBalance: String!, thirdBalance: String!,fourthBalance:String!,fifthBalance:String!,sixthBalance:String!,report:[String])
}

class SecondViewController: UIViewController {
    
    @IBOutlet weak var transactionHistory: UITextView!
    var playerOneBalance: String!
    var playerTwoBalance: String!
    var playerThreeBalance: String!
    var playerFourBalance: String!
    var playerFiveBalance: String!
    var playerSixBalance: String!
    var savedHistory = [String]()
    
    // create a variable that will recieve / send messages
    // between the view controllers.
    var delegate : SecondViewControllerDelegate?
    // another data outlet
    var data : String!
    
    
    var history = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in history {
            transactionHistory.insertText(i)
            savedHistory.append(i)
        }
    }
    
    @IBAction func goBack(sender:AnyObject){
        self.presentingViewController!.dismissViewControllerAnimated(true, completion: nil)
    }
        
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        print(playerOneBalance)
        print(playerTwoBalance)
        print(playerThreeBalance)
        print(playerFourBalance)
        print(playerFiveBalance)
        if self.isBeingDismissed() {
            self.delegate?.acceptData(playerOneBalance,secondBalance: playerTwoBalance,thirdBalance: playerThreeBalance,fourthBalance: playerFourBalance,fifthBalance: playerFiveBalance,sixthBalance: playerSixBalance, report: savedHistory)
        }
    }
    
    



}

