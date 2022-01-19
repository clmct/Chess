//
//  MenuViewController.swift
//  Chess
//

import UIKit
import SwiftChess

class MenuViewController: UIViewController {
  

  @IBOutlet weak var Easy: UIButton!
  @IBOutlet weak var Normal: UIButton!
  @IBOutlet weak var Russia: UIButton!
  
  @IBOutlet weak var AI: UIButton!
  @IBOutlet weak var H: UIButton!
  
  @IBOutlet weak var RandomKing: UIButton!
  @IBOutlet weak var WhiteKing: UIButton!
  @IBOutlet weak var BlackKing: UIButton!
  class func initWithSB() -> MenuViewController {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let className = "MenuViewController"
    let viewController: MenuViewController =
    storyboard.instantiateViewController(withIdentifier: className) as! MenuViewController
    return viewController
    
  }
  var colorToStart: String = "white"
  var vesusStart: String = "AI"
  var levelStart: String = "Normal"
  
  @IBAction func StartByBlack(_ sender: Any) {
    GetButtonpressed(buttonPressed: BlackKing)
    ButtonUp(buttonPressed: WhiteKing )
    ButtonUp(buttonPressed: RandomKing)
    colorToStart = "black"
  }
  
  @IBAction func StartByWhite(_ sender: Any) {
    GetButtonpressed(buttonPressed: WhiteKing)
    ButtonUp(buttonPressed: BlackKing)
    ButtonUp(buttonPressed: RandomKing)
    colorToStart = "white"
  }
  @IBAction func StartByRandom(_ sender: Any) {
    GetButtonpressed(buttonPressed: RandomKing)
    ButtonUp(buttonPressed: BlackKing)
    ButtonUp(buttonPressed: WhiteKing)
    colorToStart = "random"
  }
  
  
  
  @IBAction func VSAI(_ sender: Any) {
    GetButtonpressed(buttonPressed: AI)
    ButtonUp(buttonPressed: H)
    vesusStart = "AI"
  }
  
  @IBAction func VSHuman(_ sender: Any) {
    GetButtonpressed(buttonPressed: H)
    ButtonUp(buttonPressed: AI)
    vesusStart = "H"
  }
  
  
  
  @IBAction func EasyLevel(_ sender: Any) {
    GetButtonpressed(buttonPressed: Easy)
    ButtonUp(buttonPressed: Russia)
    ButtonUp(buttonPressed: Normal)
    levelStart = "Easy"
  }
  @IBAction func NormalLevel(_ sender: Any) {
    GetButtonpressed(buttonPressed: Normal)
    ButtonUp(buttonPressed: Russia)
    ButtonUp(buttonPressed: Easy)
    levelStart = "Normal"
  }
  @IBAction func WelcomeToRussia(_ sender: Any) {
    GetButtonpressed(buttonPressed: Russia)
    ButtonUp(buttonPressed: Easy)
    ButtonUp(buttonPressed: Normal)
    levelStart = "Russia"
  }
  
  // MARK: - Actions
  
  func GetButtonpressed(buttonPressed : UIButton!){
    buttonPressed.backgroundColor = .white
    buttonPressed.layer.cornerRadius = 15
      
      
      
    buttonPressed.layer.shadowColor = UIColor(named: "ShadowForButton")?.cgColor
    buttonPressed.layer.shadowRadius = 5
      
    buttonPressed.layer.shadowOpacity = 0.5
    buttonPressed.layer.shadowOffset  = CGSize(width: 0, height: 2)
  }
  func ButtonUp(buttonPressed : UIButton!){
    buttonPressed.backgroundColor = .white
    buttonPressed.layer.cornerRadius = 0
      
      
      
    buttonPressed.layer.shadowColor = UIColor(named: "ShadowForButton")?.cgColor
    buttonPressed.layer.shadowRadius = 0
      
    buttonPressed.layer.shadowOpacity = 0
    buttonPressed.layer.shadowOffset  = CGSize(width: 0, height:0)
  }
  
  
  

  @IBAction func AIvsAIButtonPressed(_ sender: UIButton) {
    
    let whitePlayer = AIPlayer(color: .white, configuration: AIConfiguration(difficulty: .hard))
    let blackPlayer = AIPlayer(color: .black, configuration: AIConfiguration(difficulty: .hard))
    
    let game = Game(firstPlayer: whitePlayer, secondPlayer: blackPlayer)
    print(colorToStart)
    print(vesusStart)
    print(levelStart)
    startGame(game: game, title: "AI vs AI")
    
  }
  
  func startGame(game: Game, title: String) {
    
    
    var You = Human(color: .white)
    
    var OppositeAI = AIPlayer(color: .white, configuration: AIConfiguration(difficulty: .hard))
    
    var OppositeH = Human(color: .white)
    
    if(vesusStart == "AI" && colorToStart == "white"){
      You = Human(color: .white)
      OppositeAI = AIPlayer(color: .black, configuration: AIConfiguration(difficulty: .hard))
    }
    if(vesusStart == "H" && colorToStart == "white"){
      You = Human(color: .white)
      OppositeH = Human(color: .black)
    }
    if(vesusStart == "AI" && colorToStart == "black"){
      You = Human(color: .black)
      OppositeAI = AIPlayer(color: .white, configuration: AIConfiguration(difficulty: .hard))
    }
    if(vesusStart == "H" && colorToStart == "black"){
      You = Human(color: .black)
      OppositeH = Human(color: .white)
    }
    if(vesusStart == "H"){
      let game = Game(firstPlayer: You, secondPlayer: OppositeH)
      let viewModel = GameViewModel(game: game)
      let gameViewController = GameViewController(viewModel: viewModel)
      self.navigationController?.pushViewController(gameViewController, animated: true)
    }
    if(vesusStart == "AI"){
      let game = Game(firstPlayer: You, secondPlayer: OppositeAI)
      let viewModel = GameViewModel(game: game)
      let gameViewController = GameViewController(viewModel: viewModel)
      self.navigationController?.pushViewController(gameViewController, animated: true)
    }
    
  }
  
  
}
