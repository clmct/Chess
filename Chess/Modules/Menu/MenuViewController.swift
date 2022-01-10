//
//  MenuViewController.swift
//  Chess
//

import UIKit
import SwiftChess

class MenuViewController: UIViewController {
  
  class func initWithSB() -> MenuViewController {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let className = "MenuViewController"
    let viewController: MenuViewController =
    storyboard.instantiateViewController(withIdentifier: className) as! MenuViewController
    return viewController
    
  }
  
  // MARK: - Actions
  
  @IBAction func playerVsAIButtonPressed(_ sender: UIButton) {
    
    let whitePlayer = Human(color: .white)
    let blackPlayer = AIPlayer(color: .black, configuration: AIConfiguration(difficulty: .hard))
    
    let game = Game(firstPlayer: whitePlayer, secondPlayer: blackPlayer)
    startGame(game: game, title: "Player vs AI")
  }
  
  @IBAction func playerVsPlayerButtonPressed(_ sender: UIButton) {
    
    let whitePlayer = Human(color: .white)
    let blackPlayer = Human(color: .black)
    
    let game = Game(firstPlayer: whitePlayer, secondPlayer: blackPlayer)
    startGame(game: game, title: "Player vs Player")
  }
  
  @IBAction func AIvsAIButtonPressed(_ sender: UIButton) {
    
    let whitePlayer = AIPlayer(color: .white, configuration: AIConfiguration(difficulty: .hard))
    let blackPlayer = AIPlayer(color: .black, configuration: AIConfiguration(difficulty: .hard))
    
    let game = Game(firstPlayer: whitePlayer, secondPlayer: blackPlayer)
    startGame(game: game, title: "AI vs AI")
  }
  
  func startGame(game: Game, title: String) {
    
    
    let whitePlayer = Human(color: .white)
    let blackPlayer = Human(color: .black)
    
    let game = Game(firstPlayer: whitePlayer, secondPlayer: blackPlayer)
    let viewModel = GameViewModel(game: game)
    let gameViewController = GameViewController(viewModel: viewModel)
    self.navigationController?.pushViewController(gameViewController, animated: true)
  }
  
  
}
