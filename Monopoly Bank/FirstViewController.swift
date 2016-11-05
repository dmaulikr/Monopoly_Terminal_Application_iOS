//
//  FirstViewController.swift
//  Monopoly Bank
//
//  Created by HASH on 7/13/16.
//  Copyright © 2016 HashimJawad. All rights reserved.
//

import UIKit
import Firebase

class FirstViewController: UIViewController, SecondViewControllerDelegate {
    
    @IBOutlet weak var player1Balance: UILabel!
    @IBOutlet weak var player2Balance: UILabel!
    @IBOutlet weak var player3Balance: UILabel!
    @IBOutlet weak var player4Balance: UILabel!
    @IBOutlet weak var player5Balance: UILabel!
    @IBOutlet weak var player6Balance: UILabel!

    @IBOutlet weak var commaButton: UIButton!
    
    var sessionName: String!
    var pass: String!

    
    @IBOutlet weak var addBalance: UIButton!
    @IBOutlet weak var removeBalance: UIButton!
    @IBOutlet weak var transferBalance: UIButton!

    @IBOutlet weak var incomeButton: UIButton!
    
    var cardChosen: String!
    
    let rootRef = FIRDatabase.database().reference()
        
    @IBOutlet weak var currentBalance: UILabel!
    
    var report = [String]()
    
    @IBOutlet weak var addedBalanceField: UITextField!
    @IBOutlet weak var addMillionButton: UIButton!
    @IBOutlet weak var addThousandButton: UIButton!
    @IBOutlet weak var cardImage: UIImageView!
    
    
    @IBOutlet weak var bluePlayerSelected: UIButton!
    @IBOutlet weak var greenPlayerSelected: UIButton!
    @IBOutlet weak var redPlayerSelected: UIButton!
    @IBOutlet weak var purplePlayerSelected: UIButton!
    @IBOutlet weak var brownPlayerSelected: UIButton!
    @IBOutlet weak var yellowPlayerSelected: UIButton!
    
    var player1Turn = false
    var player2Turn = false
    var player3Turn = false
    var player4Turn = false
    var player5Turn = false
    var player6Turn = false



    var counter = 0
    
    
    var cards = [UIImage(named: "card1"),UIImage(named: "card2"),UIImage(named: "card3"),UIImage(named: "card4"),UIImage(named: "card5"),UIImage(named: "card6")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addedBalanceField.text = "0"
        print("VIEW DID LOAD")
    }
    
    
    
    func getTime() -> String {
        let date = NSDate()
        let outputFormat = NSDateFormatter()
        outputFormat.locale = NSLocale(localeIdentifier:"en_US")
        outputFormat.dateFormat = "HH:mm:ss"
        return outputFormat.stringFromDate(date)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "TransactionHistory" {
            if let destination = segue.destinationViewController as? SecondViewController {
                destination.history = report
                destination.playerOneBalance = player1Balance.text
                destination.playerTwoBalance = player2Balance.text
                destination.playerThreeBalance = player3Balance.text
                destination.playerFourBalance = player4Balance.text
                destination.playerFiveBalance = player5Balance.text
                destination.playerSixBalance = player6Balance.text
                destination.delegate = self
                self.presentViewController(destination, animated: true, completion: nil)
            }
        }
    }
 
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        disablePlayerFromEditingOtherCards()

        let balanceRef = rootRef.child("\(sessionName)/\(pass)/players/player1/Player1Balance")
        balanceRef.observeEventType(.Value) { (snap: FIRDataSnapshot) in
            if snap.value?.description == "<null>" {
                self.updateBalanceToPlayer1()
            }
            self.player1Balance.text = (snap.value?.description)!
        }
        
        let balanceRef2 = rootRef.child("\(sessionName)/\(pass)/players/player2/Player2Balance")
        balanceRef2.observeEventType(.Value) { (snap: FIRDataSnapshot) in
            if snap.value?.description == "<null>" {
                self.updateBalanceToPlayer2()
            }
            self.player2Balance.text = (snap.value?.description)!
        }
        
        let balanceRef3 = rootRef.child("\(sessionName)/\(pass)/players/player3/Player3Balance")
        balanceRef3.observeEventType(.Value) { (snap: FIRDataSnapshot) in
            if snap.value?.description == "<null>" {
                self.updateBalanceToPlayer3()
            }
            self.player3Balance.text = (snap.value?.description)!
        }
        
        let balanceRef4 = rootRef.child("\(sessionName)/\(pass)/players/player4/Player4Balance")
        balanceRef4.observeEventType(.Value) { (snap: FIRDataSnapshot) in
            if snap.value?.description == "<null>" {
                self.updateBalanceToPlayer4()
            }
            self.player4Balance.text = (snap.value?.description)!
        }
        
        let balanceRef5 = rootRef.child("\(sessionName)/\(pass)/players/player5/Player5Balance")
        balanceRef5.observeEventType(.Value) { (snap: FIRDataSnapshot) in
            if snap.value?.description == "<null>" {
                self.updateBalanceToPlayer5()
            }
            self.player5Balance.text = (snap.value?.description)!
        }
        
        let balanceRef6 = rootRef.child("\(sessionName)/\(pass)/players/player6/Player6Balance")
        balanceRef6.observeEventType(.Value) { (snap: FIRDataSnapshot) in
            if snap.value?.description == "<null>" {
                self.updateBalanceToPlayer6()
            }
            self.player6Balance.text = (snap.value?.description)!
        }
        
        //updateVals("Player1Balance",whichPlayer: "player1",playerBalance: self.player1Balance.text!)
        //updateVals("Player2Balance",whichPlayer: "player2",playerBalance: &self.player2Balance.text!)
        //updateVals("Player3Balance",whichPlayer: "player3",playerBalance: &self.player3Balance.text!)
        //updateVals("Player4Balance",whichPlayer: "player4",playerBalance: &self.player4Balance.text!)
        //updateVals("Player5Balance",whichPlayer: "player5",playerBalance: &self.player5Balance.text!)
        
        
    }
    
    
    func updateBalanceToPlayer1() {
        rootRef.child(sessionName).child(pass).child("players").child("player1").setValue(["Player1Balance":player1Balance.text!])
        print("METHOD NAME: (updateBalanceToPlayer1) I GOT CALLED!!")
    }
    
    func updateBalanceToPlayer2() {
        rootRef.child(sessionName).child(pass).child("players").child("player2").setValue(["Player2Balance":player2Balance.text!])
        print("METHOD NAME: (updateBalanceToPlayer2) I GOT CALLED!!")
    }
    
    func updateBalanceToPlayer3() {
        rootRef.child(sessionName).child(pass).child("players").child("player3").setValue(["Player3Balance":player3Balance.text!])
        print("METHOD NAME: (updateBalanceToPlayer3) I GOT CALLED!!")
    }
    
    func updateBalanceToPlayer4() {
        rootRef.child(sessionName).child(pass).child("players").child("player4").setValue(["Player4Balance":player4Balance.text!])
        print("METHOD NAME: (updateBalanceToPlayer4) I GOT CALLED!!")
    }
    
    func updateBalanceToPlayer5() {
        rootRef.child(sessionName).child(pass).child("players").child("player5").setValue(["Player5Balance":player5Balance.text!])
        print("METHOD NAME: (updateBalanceToPlayer5) I GOT CALLED!!")
    }
    
    func updateBalanceToPlayer6() {
        rootRef.child(sessionName).child(pass).child("players").child("player6").setValue(["Player6Balance":player6Balance.text!])
        print("METHOD NAME: (updateBalanceToPlayer6) I GOT CALLED!!")
    }
    
    
    /*
    func updateVals(key:String,whichPlayer:String,playerBalance:String!) {
        var parameter = playerBalance
        let balanceRef = rootRef.child("\(sessionName)/players/\(whichPlayer)/\(key)")
        balanceRef.observeEventType(.Value) { (snap: FIRDataSnapshot) in
            parameter = (snap.value?.description)!
            print(parameter)
        }
    }
 
    func updateHistory(player:String,numOfReports: Int) {
        let history = rootRef.child("\(sessionName)/history/\(player)/\(numOfReports)/report")
        history.observeEventType(.Value) { (snap: FIRDataSnapshot) in
            print(snap.value?.description)
            self.report.append((snap.value?.description)!)
        }
    }
 */
    
    

    @IBAction func changeCardUp(sender: UIButton) {
        goUpThroughCards()
        disableTransferFunctionality()
        disablePlayerFromEditingOtherCards()
        print("METHOD NAME: (changeCardUp) I GOT CALLED!!")
    }
    
    @IBAction func changeCardDown(sender: UIButton) {
        goDownThroughCards()
        disableTransferFunctionality()
        disablePlayerFromEditingOtherCards()
        print("METHOD NAME: (changeCardDown) I GOT CALLED!!")
    }
    
    
    func goUpThroughCards() {
        
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
        print("METHOD NAME: (goUpThroughCards) I GOT CALLED!!")
    
    }
    
    func goDownThroughCards() {
        
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
        print("METHOD NAME: (goDownThroughCards) I GOT CALLED!!")
        
        
    }
    
    func checkWhichCardIsOnTheScreen() {
        
        if cardImage.image == UIImage(named: "card1") {
            player1Turn = true
            player2Turn = false
            player3Turn = false
            player4Turn = false
            player5Turn = false
            player6Turn = false
            currentBalance.text = player1Balance.text
            print(currentBalance.text)
            updateBalanceToPlayer1()
            print("card1")
        } else if (cardImage.image == UIImage(named: "card2")) {
            player1Turn = false
            player2Turn = true
            player3Turn = false
            player4Turn = false
            player5Turn = false
            player6Turn = false
            currentBalance.text = player2Balance.text
            print(currentBalance.text)
            updateBalanceToPlayer2()
            print("card2")
        } else if (cardImage.image == UIImage(named: "card3")) {
            player1Turn = false
            player2Turn = false
            player3Turn = true
            player4Turn = false
            player5Turn = false
            player6Turn = false
            currentBalance.text = player3Balance.text
            print(currentBalance.text)
            updateBalanceToPlayer3()
            print("card3")
        } else if (cardImage.image == UIImage(named: "card4")) {
            player1Turn = false
            player2Turn = false
            player3Turn = false
            player4Turn = true
            player5Turn = false
            player6Turn = false
            currentBalance.text = player4Balance.text
            print(currentBalance.text)
            updateBalanceToPlayer4()
            print("card4")
        } else if (cardImage.image == UIImage(named: "card5")) {
            player1Turn = false
            player2Turn = false
            player3Turn = false
            player4Turn = false
            player5Turn = true
            player6Turn = false
            currentBalance.text = player5Balance.text
            print(currentBalance.text)
            updateBalanceToPlayer5()
            print("card5")
        } else if (cardImage.image == UIImage(named: "card6")) {
            player1Turn = false
            player2Turn = false
            player3Turn = false
            player4Turn = false
            player5Turn = false
            player6Turn = true
            currentBalance.text = player6Balance.text
            print(currentBalance.text)
            updateBalanceToPlayer6()
            print("card6")
        }
        
        print("METHOD NAME: (checkWhichImageIsOnScreen) I GOT CALLED!!")
    }
    
    @IBAction func addMillion(sender: UIButton) {
        
        let balance = addedBalanceField.text!
        
        if (balance == "0")
        {
            sender.enabled = true
        }
        
        if balance.characters.contains(".") {
            let count = balance.characters.count
            var temp = addedBalanceField.text!
            if count >= 3 {
                temp = "\(balance)" + "00000"
            }
            sender.enabled = false
            addedBalanceField.text = "\(temp)"
            
        } else {
        
            let temp: String = "\(balance)" + "000000"
            sender.enabled = false
            addedBalanceField.text = "\(temp)"
        }
        

        
    
    }
    
    @IBAction func addComma(sender: UIButton) {
        
        let balance = addedBalanceField.text!
        var count = 0

        for i in balance.characters {
            if i == "." {
                count = count + 1
                print(".....!!..")
            }
        }
        
        if (balance == "0")
        {
            sender.enabled = true
        }
        
        if count < 1 {
            let temp: String = "\(balance)" + "."
            addedBalanceField.text = "\(temp)"
        } else
        {
            displayError("ERROR: Illegal action.")
        }

    }
    
    func convertToWholeNum(num:String) -> String {
        var number = num
        if number.characters.contains(".") {
            number.removeAtIndex(number.characters.indexOf(".")!)
        }
        return number
    }
    
    
    
    
    @IBAction func addIncome(sender: UIButton) {
        
        if (player1Turn)
        {
            var currBalance = Int(player1Balance.text!)
            currBalance = currBalance! + 2000000
            player1Balance.text = "\(currBalance!)"
            currentBalance.text = player1Balance.text
            report.append("\n [\(getTime())] - 2 million has been added to the Blue card.")
            updateBalanceToPlayer1()
        }
        else if (player2Turn)
        {
            var currBalance = Int(player2Balance.text!)
            currBalance = currBalance! + 2000000
            player2Balance.text = "\(currBalance!)"
            currentBalance.text = player2Balance.text
            report.append("\n [\(getTime())] - 2 million has been added to the Green card.")
            updateBalanceToPlayer2()

        }
        else if (player3Turn)
        {
            var currBalance = Int(player3Balance.text!)
            currBalance = currBalance! + 2000000
            player3Balance.text = "\(currBalance!)"
            currentBalance.text = player3Balance.text
            report.append("\n [\(getTime())] - 2 million has been added to the Red card.")
            updateBalanceToPlayer3()
        }
        else if (player4Turn)
        {

            var currBalance = Int(player4Balance.text!)
            currBalance = currBalance! + 2000000
            player4Balance.text = "\(currBalance!)"
            currentBalance.text = player4Balance.text
            report.append("\n [\(getTime())] - 2 million has been added to the Purple card.")
            updateBalanceToPlayer4()
            
        }
        else if (player5Turn)
        {
            var currBalance = Int(player5Balance.text!)
            currBalance = currBalance! + 2000000
            player5Balance.text = "\(currBalance!)"
            currentBalance.text = player5Balance.text
            report.append("\n [\(getTime())] - 2 million has been added to the Orange card.")
            updateBalanceToPlayer5()
            
        }
        else if (player6Turn) {
            
            var currBalance = Int(player6Balance.text!)
            currBalance = currBalance! + 2000000
            player6Balance.text = "\(currBalance!)"
            currentBalance.text = player6Balance.text
            report.append("\n [\(getTime())] - 2 million has been added to the Yellow card.")
            updateBalanceToPlayer6()
        }
        
    }
    
    
    @IBAction func addThousand(sender: UIButton) {

        let balance = addedBalanceField.text!
        
        if (balance == "0") {
            sender.enabled = true
        }
        
        if balance.characters.contains(".") {
            let count = balance.characters.count
            var temp = addedBalanceField.text!
            if count >= 3 {
                temp = "\(balance)" + "00"
            }
            sender.enabled = false
            addedBalanceField.text = "\(temp)"
            
        } else {
            
            let temp: String = "\(balance)" + "000"
            sender.enabled = false
            addedBalanceField.text = "\(temp)"
        }
    }
    
    
    
    @IBAction func addZero(sender: UIButton) { addToBalance("0") }
    
    @IBAction func addOne(sender: UIButton) { addToBalance("1") }
    
    @IBAction func addTwo(sender: UIButton) { addToBalance("2") }
    
    @IBAction func addThree(sender: UIButton) { addToBalance("3") }
    
    @IBAction func addFour(sender: UIButton) { addToBalance("4") }
    
    @IBAction func addFive(sender: UIButton) { addToBalance("5") }
    
    @IBAction func addSix(sender: UIButton) { addToBalance("6") }
    
    @IBAction func addSeven(sender: UIButton) { addToBalance("7") }
    
    @IBAction func addEight(sender: UIButton) { addToBalance("8") }
    
    @IBAction func addNine(sender: UIButton) { addToBalance("9") }
    
    
    @IBAction func clear(sender: UIButton) {
        
        addMillionButton.enabled = true
        addThousandButton.enabled = true
        addedBalanceField.text = "0"
        
    }
    
    func addToBalance(number: String) {
        
        var balance = addedBalanceField.text!
        
        if (balance == "0") {
            balance = number
        }
        else
        {
            let temp: String = "\(balance)" + number
            balance = temp
        }
        
        addedBalanceField.text = "\(balance)"
    }
    
    
    @IBAction func addToCurrBalance(sender: UIButton) {
        
        let player1 = Int(player1Balance.text!)
        let player2 = Int(player2Balance.text!)
        let player3 = Int(player3Balance.text!)
        let player4 = Int(player4Balance.text!)
        let player5 = Int(player5Balance.text!)
        let player6 = Int(player6Balance.text!)
        let balanceString = addedBalanceField.text!
        var balance = Int(addedBalanceField.text!)
        if balanceString.characters.contains(".") {
            let balanceString = convertToWholeNum(balanceString)
            balance = Int(balanceString)
        }
    
        if (player1Turn)
        {
            print("player1")
            let total = balance! + player1!
            player1Balance.text = "\(total)"
            currentBalance.text = player1Balance.text
            if balance > 0 {
                report.append("\n [\(getTime())] - Blue card added \(balance!). The new balance for the blue card is \(player1Balance.text!)")
                updateBalanceToPlayer1()

            }
        }
        else if (player2Turn)
        {
            print("player2")
            let total = balance! + player2!
            player2Balance.text = "\(total)"
            currentBalance.text = player2Balance.text
            if balance > 0 {
                report.append("\n [\(getTime())] - Green card added \(balance!). The new balance for the green card is \(player2Balance.text!)")
                updateBalanceToPlayer2()

            }

            
        }
        else if (player3Turn)
        {
            print("player3")
            let total = balance! + player3!
            player3Balance.text = "\(total)"
            currentBalance.text = player3Balance.text
            if balance > 0 {
                report.append("\n [\(getTime())] - Red card added \(balance!). The new balance for the red card is \(player3Balance.text!)")
                updateBalanceToPlayer3()
            }



        }
        else if (player4Turn)
        {
            print("player4")
            let total = balance! + player4!
            player4Balance.text = "\(total)"
            currentBalance.text = player4Balance.text
            if balance > 0 {
                report.append("\n [\(getTime())] - Purple card added \(balance!). The new balance for the purple card is \(player4Balance.text!)")
                updateBalanceToPlayer4()
            }


        }
        else if (player5Turn)
        {
            print("player5")
            let total = balance! + player5!
            player5Balance.text = "\(total)"
            currentBalance.text = player5Balance.text
            if balance > 0 {
                report.append("\n [\(getTime())] - Orange card added \(balance!). The new balance for the orange card is \(player5Balance.text!)")
                updateBalanceToPlayer5()
            }
            
        }
        else if (player6Turn)
        {
            print("player6")
            let total = balance! + player6!
            player6Balance.text = "\(total)"
            currentBalance.text = player6Balance.text
            if balance > 0 {
                report.append("\n [\(getTime())] - Yellow card added \(balance!). The new balance for the yellow card is \(player6Balance.text!)")
                updateBalanceToPlayer6()
            }
            
        }
        
        addedBalanceField.text = "0"
        addMillionButton.enabled = true
        addThousandButton.enabled = true
        
    }

    
    @IBAction func removeFromCurrBalance(sender: AnyObject) {
        
        let player1 = Int(player1Balance.text!)
        let player2 = Int(player2Balance.text!)
        let player3 = Int(player3Balance.text!)
        let player4 = Int(player4Balance.text!)
        let player5 = Int(player5Balance.text!)
        let player6 = Int(player6Balance.text!)
        var balance = Int(addedBalanceField.text!)
        let balanceString = addedBalanceField.text!
        if balanceString.characters.contains(".") {
            let balanceString = convertToWholeNum(balanceString)
            balance = Int(balanceString)
        }
        
        if (cardImage.image == UIImage(named: "card1"))
        {
            let total = player1! - balance!
            if total < 0 {
                displayError()
            } else {
                player1Balance.text = "\(total)"
                currentBalance.text = player1Balance.text
                addedBalanceField.text = "0"
                addMillionButton.enabled = true
                addThousandButton.enabled = true
                if balance > 0 {
                    report.append("\n [\(getTime())] - Blue card removed \(balance!). The new balance for the red card is \(player1Balance.text!)")
                    updateBalanceToPlayer1()
                }
            }
        }
        else if (cardImage.image == UIImage(named: "card2"))
        {
            let total = player2! - balance!
            if total < 0 {
                displayError()
            } else {
                player2Balance.text = "\(total)"
                currentBalance.text = player2Balance.text
                addedBalanceField.text = "0"
                addMillionButton.enabled = true
                addThousandButton.enabled = true
                if balance > 0 {
                    report.append("\n [\(getTime())] - Green card removed \(balance!). The new balance for the red card is \(player2Balance.text!)")
                    updateBalanceToPlayer2()
                }
            }
        }
        else if (cardImage.image == UIImage(named: "card3"))
        {
            let total = player3! - balance!
            if total < 0 {
                displayError()
            } else {
                player3Balance.text = "\(total)"
                currentBalance.text = player3Balance.text
                addedBalanceField.text = "0"
                addMillionButton.enabled = true
                addThousandButton.enabled = true
                if balance > 0 {
                    report.append("\n [\(getTime())] - Red card removed \(balance!). The new balance for the red card is \(player3Balance.text!)")
                    updateBalanceToPlayer3()
                }


            }
        }
        else if (cardImage.image == UIImage(named: "card4"))
        {
            let total = player4! - balance!
            if total < 0 {
                displayError()
            } else {
                player4Balance.text = "\(total)"
                currentBalance.text = player4Balance.text
                addedBalanceField.text = "0"
                addMillionButton.enabled = true
                addThousandButton.enabled = true
                if balance > 0 {
                    report.append("\n [\(getTime())] - Purple card removed \(balance!). The new balance for the purple card is \(player4Balance.text!)")
                    updateBalanceToPlayer4()
                }
            }
        }
        else if (cardImage.image == UIImage(named: "card5"))
        {
            let total = player5! - balance!
            if total < 0 {
                displayError()
            } else {
                player5Balance.text = "\(total)"
                currentBalance.text = player5Balance.text
                addedBalanceField.text = "0"
                addMillionButton.enabled = true
                addThousandButton.enabled = true
                if balance > 0 {
                    report.append("\n [\(getTime())] - Orange card removed \(balance!). The new balance for the orange card is \(player3Balance.text!)")
                    updateBalanceToPlayer5()
                }
            }
        }
        else
        {
            let total = player6! - balance!
            if total < 0 {
                displayError()
            } else {
                player6Balance.text = "\(total)"
                currentBalance.text = player6Balance.text
                addedBalanceField.text = "0"
                addMillionButton.enabled = true
                addThousandButton.enabled = true
                if balance > 0 {
                    report.append("\n [\(getTime())] - Yellow card removed \(balance!). The new balance for the yellow card is \(player6Balance.text!)")
                    updateBalanceToPlayer6()
                }
            }
        }
    }
    
    @IBAction func greenIsPressed(sender: UIButton) {
        transferMoney(&player2Balance.text!)
    }
    
    
    @IBAction func redIsPressed(sender: UIButton) {
        transferMoney(&player3Balance.text!)
    }
    
    @IBAction func purpleIsPressed(sender: UIButton) {
        transferMoney(&player4Balance.text!)
    }
    
    @IBAction func blueIsPressed(sender: UIButton){
        transferMoney(&player1Balance.text!)
    }
    
    @IBAction func brownIsPressed(sender: UIButton) {
        transferMoney(&player5Balance.text!)
    }
    
    @IBAction func yellowIsPressed(sender: UIButton) {
        transferMoney(&player6Balance.text!)
    }
    
    func transferMoney(inout playerBalance: String) {
        
        var player1 = Int(playerBalance)
        var playerOne = Int(player1Balance.text!)
        var player2 = Int(player2Balance.text!)
        var player3 = Int(player3Balance.text!)
        var player4 = Int(player4Balance.text!)
        var player5 = Int(player5Balance.text!)
        var player6 = Int(player6Balance.text!)
        var balance = Int(addedBalanceField.text!)
        let balanceString = addedBalanceField.text!
        if balanceString.characters.contains(".") {
            let balanceString = convertToWholeNum(balanceString)
            balance = Int(balanceString)
        }
        
        if addedBalanceField.text == "0" || addedBalanceField.text == nil {
            displayError("ERROR: Please enter the amount of money to be transferred.")
        }
        else
        {
            if balance > player2 || balance > player3 || balance > player4 || balance > player5 {
                displayError()
            }
            else
            {
                if player1Turn == true {
                    
                    player1 = player1! + balance!
                    playerOne = playerOne! - balance!
                    playerBalance = "\(player1!)"
                    player1Balance.text = "\(playerOne!)"
                    addedBalanceField.text = "0"
                    currentBalance.text = player1Balance.text
                    addMillionButton.enabled = true
                    addThousandButton.enabled = true
                    hideTransferOptions()
                    addTransferTransactionToReport(balance!)
                
                }
                else if player2Turn == true {
                    player1 = player1! + balance!
                    player2 = player2! - balance!
                    playerBalance = "\(player1!)"
                    player2Balance.text = "\(player2!)"
                    addedBalanceField.text = "0"
                    currentBalance.text = player2Balance.text
                    addMillionButton.enabled = true
                    addThousandButton.enabled = true
                    hideTransferOptions()
                    addTransferTransactionToReport(balance!)
                    
                } else if player3Turn == true {
                    player1 = player1! + balance!
                    player3 = player3! - balance!
                    playerBalance = "\(player1!)"
                    player3Balance.text = "\(player3!)"
                    addedBalanceField.text = "0"
                    currentBalance.text = player3Balance.text
                    addMillionButton.enabled = true
                    addThousandButton.enabled = true
                    hideTransferOptions()
                    addTransferTransactionToReport(balance!)

                } else if player4Turn == true {
                    player1 = player1! + balance!
                    player4 = player4! - balance!
                    playerBalance = "\(player1!)"
                    player4Balance.text = "\(player4!)"
                    addedBalanceField.text = "0"
                    currentBalance.text = player4Balance.text
                    addMillionButton.enabled = true
                    addThousandButton.enabled = true
                    hideTransferOptions()
                    addTransferTransactionToReport(balance!)

                } else if player5Turn == true {
                    player1 = player1! + balance!
                    player5 = player5! - balance!
                    playerBalance = "\(player1!)"
                    player5Balance.text = "\(player5!)"
                    addedBalanceField.text = "0"
                    currentBalance.text = player5Balance.text
                    addMillionButton.enabled = true
                    addThousandButton.enabled = true
                    hideTransferOptions()
                    addTransferTransactionToReport(balance!)

                } else if player6Turn == true {
                    player1 = player1! + balance!
                    player6 = player6! - balance!
                    playerBalance = "\(player1!)"
                    player6Balance.text = "\(player6!)"
                    addedBalanceField.text = "0"
                    currentBalance.text = player6Balance.text
                    addMillionButton.enabled = true
                    addThousandButton.enabled = true
                    hideTransferOptions()
                    addTransferTransactionToReport(balance!)
                }
            }
        }
    }
    
    
    func displayError() {
        let alert = UIAlertController(title: "ERROR", message: "Insufficent balance.", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
            addedBalanceField.text = "0"
    }
    
    func displayError(msg:String) {
        let alert = UIAlertController(title: "ERROR", message: msg, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func hideTransferOptions() {
        bluePlayerSelected.hidden = true
        greenPlayerSelected.hidden = true
        redPlayerSelected.hidden = true
        purplePlayerSelected.hidden = true
        brownPlayerSelected.hidden = true
        yellowPlayerSelected.hidden = true
    }
    
    @IBAction func transferBalance(sender: UIButton) {
        
        if bluePlayerSelected.hidden == true
        {
            bluePlayerSelected.hidden = false
        }
        else
        {
            bluePlayerSelected.hidden = true
            
        }
        
        if redPlayerSelected.hidden == true
        {
            redPlayerSelected.hidden = false
        }
        else
        {
            redPlayerSelected.hidden = true
            
        }
        
        if purplePlayerSelected.hidden == true
        {
            purplePlayerSelected.hidden = false
        }
        else
        {
            purplePlayerSelected.hidden = true
            
        }
        
        if greenPlayerSelected.hidden == true
        {
            greenPlayerSelected.hidden = false
        }
        else
        {
            greenPlayerSelected.hidden = true
            
        }
        
        if brownPlayerSelected.hidden == true
        {
            brownPlayerSelected.hidden = false
        }
        else
        {
            brownPlayerSelected.hidden = true
            
        }
        
        if yellowPlayerSelected.hidden == true
        {
            yellowPlayerSelected.hidden = false
        }
        else
        {
            yellowPlayerSelected.hidden = true
            
        }
        
        
    }
    
    func disableTransferFunctionality() {
        if player1Turn {
            bluePlayerSelected.enabled = false
            greenPlayerSelected.enabled = true
            redPlayerSelected.enabled = true
            purplePlayerSelected.enabled = true
            brownPlayerSelected.enabled = true
            yellowPlayerSelected.enabled = true
        }
        else if player2Turn {
            bluePlayerSelected.enabled = true
            greenPlayerSelected.enabled = false
            redPlayerSelected.enabled = true
            purplePlayerSelected.enabled = true
            brownPlayerSelected.enabled = true
            yellowPlayerSelected.enabled = true
        }
        else if player3Turn {
            bluePlayerSelected.enabled = true
            greenPlayerSelected.enabled = true
            redPlayerSelected.enabled = false
            purplePlayerSelected.enabled = true
            brownPlayerSelected.enabled = true
            yellowPlayerSelected.enabled = true
            
        }
        else if player4Turn {
            bluePlayerSelected.enabled = true
            greenPlayerSelected.enabled = true
            redPlayerSelected.enabled = true
            purplePlayerSelected.enabled = false
            brownPlayerSelected.enabled = true
            yellowPlayerSelected.enabled = true
        }
        else if player5Turn {
            bluePlayerSelected.enabled = true
            greenPlayerSelected.enabled = true
            redPlayerSelected.enabled = true
            purplePlayerSelected.enabled = true
            brownPlayerSelected.enabled = false
            yellowPlayerSelected.enabled = true
        }
        else if player6Turn {
            bluePlayerSelected.enabled = true
            greenPlayerSelected.enabled = true
            redPlayerSelected.enabled = true
            purplePlayerSelected.enabled = true
            brownPlayerSelected.enabled = true
            yellowPlayerSelected.enabled = false
        }
        else
        {
            bluePlayerSelected.enabled = false
            greenPlayerSelected.enabled = false
            redPlayerSelected.enabled = false
            purplePlayerSelected.enabled = false
            brownPlayerSelected.enabled = false
            yellowPlayerSelected.enabled = false
            
        }
    }
    
    func addTransferTransactionToReport(balance: Int) {
        
        if player1Turn {
            if greenPlayerSelected.touchInside == true {
                report.append("\n [\(getTime())] - Blue card transfered \(balance) to Green card. The new balance for the blue card is \(player1Balance.text!)")
            } else if redPlayerSelected.touchInside == true {
                report.append("\n [\(getTime())] - Blue card transfered \(balance) to Red card. The new balance for the blue card is \(player1Balance.text!)")
            } else if purplePlayerSelected.touchInside == true {
                report.append("\n [\(getTime())] - Blue card transfered \(balance) to Purple card. The new balance for the blue card is \(player1Balance.text!)")
            } else if brownPlayerSelected.touchInside == true {
                report.append("\n [\(getTime())] - Blue card transfered \(balance) to Orange card. The new balance for the blue card is \(player1Balance.text!)")
            } else if yellowPlayerSelected.touchInside == true {
                report.append("\n [\(getTime())] - Blue card transfered \(balance) to Yellow card. The new balance for the blue card is \(player1Balance.text!)")
            }
        } else if player2Turn {
            if bluePlayerSelected.touchInside == true {
                report.append("\n [\(getTime())] - Green card transfered \(balance) to Blue card. The new balance for the green card is \(player2Balance.text!)")
            } else if redPlayerSelected.touchInside == true {
                report.append("\n [\(getTime())] - Green card transfered \(balance) to Red card. The new balance for the green card is \(player2Balance.text!)")
            } else if purplePlayerSelected.touchInside == true {
                report.append("\n [\(getTime())] - Green card transfered \(balance) to Purple card. The new balance for the green card is \(player2Balance.text!)")
            } else if brownPlayerSelected.touchInside == true {
                report.append("\n [\(getTime())] - Green card transfered \(balance) to Orange card. The new balance for the green card is \(player2Balance.text!)")
            } else if yellowPlayerSelected.touchInside == true {
                report.append("\n [\(getTime())] - Green card transfered \(balance) to Yellow card. The new balance for the green card is \(player2Balance.text!)")
            }
        } else if player3Turn {
            
            if greenPlayerSelected.touchInside == true {
                report.append("\n [\(getTime())] - Red card transfered \(balance) to Green card. The new balance for the red card is \(player3Balance.text!)")
            } else if bluePlayerSelected.touchInside == true {
                report.append("\n [\(getTime())] - Red card transfered \(balance) to Blue card. The new balance for the red card is \(player3Balance.text!)")
            } else if purplePlayerSelected.touchInside == true {
                report.append("\n [\(getTime())] - Red card transfered \(balance) to Purple card. The new balance for the red card is \(player3Balance.text!)")
            } else if brownPlayerSelected.touchInside == true {
                report.append("\n [\(getTime())] - Red card transfered \(balance) to Orange card. The new balance for the red card is \(player3Balance.text!)")
            } else if yellowPlayerSelected.touchInside == true {
                report.append("\n [\(getTime())] - Red card transfered \(balance) to Yellow card. The new balance for the red card is \(player3Balance.text!)")
            }
        } else if player4Turn {
            
            if greenPlayerSelected.touchInside == true {
                report.append("\n [\(getTime())] - Purple card transfered \(balance) to Green card. The new balance for the purple card is \(player4Balance.text!)")
            } else if redPlayerSelected.touchInside == true {
                report.append("\n [\(getTime())] - Purple card transfered \(balance) to Red card. The new balance for the purple card is \(player4Balance.text!)")
            } else if bluePlayerSelected.touchInside == true {
                report.append("\n [\(getTime())] - Purple card transfered \(balance) to Blue card. The new balance for the purple card is \(player4Balance.text!)")
            } else if brownPlayerSelected.touchInside == true {
                report.append("\n [\(getTime())] - Purple card transfered \(balance) to Orange card. The new balance for the purple card is \(player4Balance.text!)")
            } else if yellowPlayerSelected.touchInside == true {
                report.append("\n [\(getTime())] - Purple card transfered \(balance) to Yellow card. The new balance for the purple card is \(player4Balance.text!)")
            }
        } else if player5Turn {
            if greenPlayerSelected.touchInside == true {
                report.append("\n [\(getTime())] - Orange card transfered \(balance) to Green card. The new balance for the orange card is \(player5Balance.text!)")
            } else if redPlayerSelected.touchInside == true {
                report.append("\n [\(getTime())] - Orange card transfered \(balance) to Red card. The new balance for the orange card is \(player5Balance.text!)")
            } else if purplePlayerSelected.touchInside == true {
                report.append("\n [\(getTime())] - Orange card transfered \(balance) to Purple card. The new balance for the orange card is \(player5Balance.text!)")
            } else if bluePlayerSelected.touchInside == true {
                report.append("\n [\(getTime())] - Orange card transfered \(balance) to Blue card. The new balance for the orange card is \(player5Balance.text!)")
            } else if yellowPlayerSelected.touchInside == true {
                report.append("\n [\(getTime())] - Orange card transfered \(balance) to Yellow card. The new balance for the orange card is \(player5Balance.text!)")
            }
        } else if player6Turn {
            if bluePlayerSelected.touchInside == true {
                report.append("\n [\(getTime())] - Yellow card transfered \(balance) to blue card. The new balance for the yellow card is \(player6Balance.text!)")
            } else if greenPlayerSelected.touchInside == true {
                report.append("\n [\(getTime())] - Yellow card transfered \(balance) to green card. The new balance for the yellow card is \(player6Balance.text!)")
            } else if redPlayerSelected.touchInside == true {
                report.append("\n [\(getTime())] - Yellow card transfered \(balance) to red card. The new balance for the yellow card is \(player6Balance.text!)")
            } else if purplePlayerSelected.touchInside == true {
                report.append("\n [\(getTime())] - Yellow card transfered \(balance) to purple card. The new balance for the yellow card is \(player6Balance.text!)")
            } else if brownPlayerSelected.touchInside == true {
                report.append("\n [\(getTime())] - Yellow card transfered \(balance) to Orange card. The new balance for the yellow card is \(player6Balance.text!)")
            }
        }
    }
 
    
    func acceptData(firstBalance: String!,secondBalance: String!, thirdBalance: String!,fourthBalance:String!,fifthBalance:String!,sixthBalance:String!,report:[String]) {
        self.player1Balance.text = firstBalance
        self.player2Balance.text = secondBalance
        self.player3Balance.text = thirdBalance
        self.player4Balance.text = fourthBalance
        self.player5Balance.text = fifthBalance
        self.player6Balance.text = sixthBalance
        self.report = report
        print("METHOD NAME: (acceptData) I GOT CALLED!!")
    }
    
    func disableColoredSqaures(bool: Bool) {
        bluePlayerSelected.hidden = bool
        greenPlayerSelected.hidden = bool
        redPlayerSelected.hidden = bool
        purplePlayerSelected.hidden = bool
        brownPlayerSelected.hidden = bool
        yellowPlayerSelected.hidden = bool
        
    }
    
    func disablePlayerFromEditingOtherCards() {
        if cardChosen == "BlueCard" {
            if player1Turn == true {
                addBalance.hidden = false
                removeBalance.hidden = false
                transferBalance.hidden = false
                incomeButton.hidden = false
            } else {
                addBalance.hidden = true
                removeBalance.hidden = true
                transferBalance.hidden = true
                incomeButton.hidden = true
                disableColoredSqaures(true)
            }
        } else if cardChosen == "GreenCard" {
            if player2Turn == true {
                addBalance.hidden = false
                removeBalance.hidden = false
                transferBalance.hidden = false
                incomeButton.hidden = false
            } else {
                addBalance.hidden = true
                removeBalance.hidden = true
                transferBalance.hidden = true
                incomeButton.hidden = true
                disableColoredSqaures(true)
            }
        } else if cardChosen == "RedCard" {
            if player3Turn == true {
                addBalance.hidden = false
                removeBalance.hidden = false
                transferBalance.hidden = false
                incomeButton.hidden = false
            } else {
                addBalance.hidden = true
                removeBalance.hidden = true
                transferBalance.hidden = true
                incomeButton.hidden = true
                disableColoredSqaures(true)
            }
        } else if cardChosen == "PurpleCard" {
            if player4Turn == true {
                addBalance.hidden = false
                removeBalance.hidden = false
                transferBalance.hidden = false
                incomeButton.hidden = false
            } else {
                addBalance.hidden = true
                removeBalance.hidden = true
                transferBalance.hidden = true
                incomeButton.hidden = true
                disableColoredSqaures(true)
            }
        } else if cardChosen == "OrangeCard" {
            if player5Turn == true {
                addBalance.hidden = false
                removeBalance.hidden = false
                transferBalance.hidden = false
                incomeButton.hidden = false
            } else {
                addBalance.hidden = true
                removeBalance.hidden = true
                transferBalance.hidden = true
                incomeButton.hidden = true
                disableColoredSqaures(true)
            }
        } else if cardChosen == "YellowCard" {
            if player6Turn == true {
                addBalance.hidden = false
                removeBalance.hidden = false
                transferBalance.hidden = false
                incomeButton.hidden = false
            } else {
                addBalance.hidden = true
                removeBalance.hidden = true
                transferBalance.hidden = true
                incomeButton.hidden = true
                disableColoredSqaures(true)
            }
            
        }
    }
    
    @IBAction func mainMenuPressed(sender: UIButton) {
        
        performSegueWithIdentifier("MainMenu", sender: nil)
        
    }
    

}

