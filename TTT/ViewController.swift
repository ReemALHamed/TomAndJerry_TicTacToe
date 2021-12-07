//
//  ViewController.swift
//  TTT
//
//  Created by admin on 02/12/2021.
//

import UIKit

class ViewController: UIViewController {
    
    var currentPlayer = "tom"
    var tom = [Int]()
    var jerry = [Int]()
    var win = false
    
    @IBOutlet weak var turnLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // the app was loading too fast that (choose player dialog) didn't get the chance to be displayed, so i needed to run it on its own thread so it can run asynchronously without waiting for the app
        DispatchQueue.main.async {
            self.choosePlayerDialog()
        }
        
    }

    func choosePlayerDialog(){
        // allow the user to decide who will start the game
        
        let alert = UIAlertController(title: "Choose Player", message: "Choose who will start the game ?" , preferredStyle: UIAlertController.Style.alert)
        // if the user chooses TOM, update the layout
        alert.addAction(UIAlertAction(title: "Tom", style: UIAlertAction.Style.cancel, handler: { [self] action in
            self.currentPlayer = "tom"
            self.turnLabel.text = "Tom's Turn"
            self.turnLabel.textColor = .systemIndigo
        }))
        // if the user choose JERRY, update the layout
        alert.addAction(UIAlertAction(title: "Jerry", style: UIAlertAction.Style.default, handler: { [self] action in
            self.currentPlayer = "jerry"
            self.turnLabel.text = "Jerry's Turn"
            self.turnLabel.textColor = .orange
        }))
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    func myResetDialog(){
        // clear the game progress to start a new one
        resetGame()
        let alert = UIAlertController(title: "Reset Game", message: "Are You Sure You Want To Reset The Game ? You'll Lose Your Progress !" , preferredStyle: UIAlertController.Style.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "Reset", style: UIAlertAction.Style.destructive, handler: { action in
            self.newGame()
            self.choosePlayerDialog()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    func winDialog(winner: String){
        resetGame()
        // a win is found
        win = true
        let alert = UIAlertController(title: "Congrats !", message: "\(winner) Won The Game !" , preferredStyle: UIAlertController.Style.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "Play Again", style: UIAlertAction.Style.default, handler: { action in self.newGame()}))
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    func tieDialog(){
        resetGame()
        let alert = UIAlertController(title: "Tie !", message: "This is a tie, no one won this round :)" , preferredStyle: UIAlertController.Style.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "Play Again", style: UIAlertAction.Style.default, handler: { action in self.newGame()}))
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
    // chack that the button is not taken alredy by eaither tom or jerry
        if !tom.contains(sender.tag) && !jerry.contains(sender.tag) {
        switch currentPlayer {
            case "tom":
            // if the current player who pressed the button is tom , set the button to tom's image
            sender.setImage(UIImage(named: "tom.png"), for: .normal)
            // add the button tag/position to tom's buttons array
            tom.append(sender.tag)
            // check if tom made a strike or not
            checkWinner(checkArray: tom,winnerName: "Tom")
            // if tom didn't scoe a win yet , move the turn to the next player JERRY
            currentPlayer = "jerry"
            turnLabel.text = "Jerry's Turn"
            turnLabel.textColor = .orange
            // if all the buttons are marked and there is NO WINS found , then this is a tie
            if tom.count+jerry.count == 9 && !win{
                    tieDialog()
            }else{
                // other wise go on with the game and set the wins to none
                win = false
            }
                
            case "jerry":
            // same situation going here so no need to repeat :)
            sender.setImage(UIImage(named: "jerry.png"), for: .normal)
            jerry.append(sender.tag)
            checkWinner(checkArray: jerry,winnerName: "Jerry")
            currentPlayer = "tom"
            turnLabel.text = "Tom's Turn"
            turnLabel.textColor = .systemIndigo
            
            if tom.count+jerry.count == 9 && !win{
                tieDialog()
            }else{
                win = false
            }
            default:
            // if something went wrong just restart the game and let the players choose who will start
            self.loadView()
            choosePlayerDialog()
            }
        }
    }
    @IBAction func resetButton(_ sender: Any) {
        resetGame()
        myResetDialog()
    }
    func checkWinner(checkArray : [Int], winnerName:String){
        // check if tom's/jerry's buttons array contains any of these winning sets , if so , declare the one who has it as a winner
        if [1,2,3].allSatisfy(checkArray.contains) ||
            [4,5,6].allSatisfy(checkArray.contains) ||
            [3,5,7].allSatisfy(checkArray.contains) ||
            [7,8,9].allSatisfy(checkArray.contains) ||
            [1,4,7].allSatisfy(checkArray.contains) ||
            [2,5,8].allSatisfy(checkArray.contains) ||
            [3,6,9].allSatisfy(checkArray.contains) ||
            [1,5,9].allSatisfy(checkArray.contains){
            winDialog(winner: winnerName)
        }
    }
    func resetGame(){
        tom.removeAll()
        jerry.removeAll()
        win = false
        
        
    }
    func newGame(){
        self.loadView()
        
        if currentPlayer == "tom"{
            turnLabel.text = "Tom's Turn"
            turnLabel.textColor = .systemIndigo
        }else{
            turnLabel.text = "Jerry's Turn"
            turnLabel.textColor = .orange
        }
    
    }
}

