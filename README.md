# Tom And Jerry TicTacToe

Back with one of the most famous wars in the history of cats vs mice .. THE LEGENDS .. the long-life enemies TOM & JERRY are here to win the ULTIMATE TIC TAC TOE Game!

## " TO WIN OR NOT TO WIN " 
All what it takes is a good strategy to win .. but the real question is " WHOSE SIDE ARE U ON ? "

https://user-images.githubusercontent.com/85634099/145588815-9184b35a-f772-4622-9287-df1d23ff0fbf.mp4


# Step 1: Pick a side !

Using alert dialog , The game starts by asking the players who will start first , u might as well consider tossing a coin to decide .. or simply enjoy the fight :)
upon choice you'll notice that the (Turns Label) above the game board has changed text & color to indicate who the current player is !
```
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
    
```

https://user-images.githubusercontent.com/85634099/145591011-cf838f39-3e2a-4b70-b6cc-8b2fe5ed2871.mp4


# Step 2 : Mark your territory !
Once you decide you move click on the spot to be marked as yours :) and this is how its happening:
1)  Checking that the spot isn't already taken (NO CHEATING)
2)  Check who the current player is (Tom || Jerry) using the variable [CurrentPlayer]
3)  Set the spot to display the current player's logo/image 
4)  Set the [Turn label] text to display the player's name that should play next and set its' color too (orange = Jerry , Indigo = Tom)
```
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
            // if tom didn't score a win yet , move the turn to the next player JERRY
            currentPlayer = "jerry"
            turnLabel.text = "Jerry's Turn"
            turnLabel.textColor = .orange
            // 
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
            
            else{
                win = false
            }
            default:
            // if something went wrong just restart the game and let the players choose who will start
            self.loadView()
            choosePlayerDialog()
            }
        }
    }
```

# Step 3 : Strategy is Key !
Whether it's horizontal , vertical or even diagonal .. once you get 3 in a row YOU WILL BE THE WINNER ! so make sure to plan it well cuz you might end in a tie .. or worse .. YOU LOSE X_X

But no worries we will check for every strike possibility to make sure its' fare and square :)
```
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
```
### 1) Win
once a strike is found , an alert dialog will appear declaring who the winner is ! and by clicking on "Play Again" the game will restart for the war to be continued :P
```
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
```


https://user-images.githubusercontent.com/85634099/145597826-064dbb86-2902-46ee-9d70-0036df52f881.mp4



### 2) Tie
And if you ran out of spots and yet with no wins .. this means the game has ended in a tie :O and a small alert wil pop up !
```
if tom.count+jerry.count == 9 && !win{
                tieDialog()
            }
            
    func tieDialog(){
        resetGame()
        let alert = UIAlertController(title: "Tie !", message: "This is a tie, no one won this round :)" , preferredStyle: UIAlertController.Style.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "Play Again", style: UIAlertAction.Style.default, handler: { action in self.newGame()}))
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }            
```


https://user-images.githubusercontent.com/85634099/145598030-ae127295-ee97-40ee-9ef2-877467b0e46e.mp4


## 3) Restart The game
You chose a wrong move ? someone cheated ? no worries just click restart and the game will start all over :D
```
       
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
```


https://user-images.githubusercontent.com/85634099/145598069-7207ccac-bae8-4f5d-bb03-734723f9a4cb.mp4

