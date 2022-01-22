//
//  MenuViewController.swift
//  Chess
//

import UIKit
import SwiftChess
import AVFoundation
import AVKit
import Hero

class MenuViewController: UIViewController {
  
  @IBOutlet weak var image1: UIImageView!
  @IBOutlet weak var image2: UIImageView!
  
  @IBOutlet weak var score: UILabel!
  @IBOutlet weak var Easy: UIButton!
  @IBOutlet weak var Normal: UIButton!
  @IBOutlet weak var Russia: UIButton!
  
  @IBOutlet weak var question: UIButton!
  @IBOutlet weak var AI: UIButton!
  @IBOutlet weak var H: UIButton!
  
  @IBOutlet weak var RandomKing: UIButton!
  @IBOutlet weak var WhiteKing: UIButton!
  @IBOutlet weak var BlackKing: UIButton!
  
  var colorToStart: String = "white"
  var vesusStart: String = "AI"
  var levelStart: String = "Normal"
  var audio:AVPlayer!
  
  class func initWithSB() -> MenuViewController {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let className = "MenuViewController"
    let viewController: MenuViewController =
    storyboard.instantiateViewController(withIdentifier: className) as! MenuViewController
    return viewController
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    question.backgroundColor = .white
    question.layer.cornerRadius = 8
    question.layer.shadowRadius = 4
      
    question.layer.shadowOpacity = 0.3
    question.layer.shadowOffset  = CGSize(width: 0, height: 2)
    let url = Bundle.main.url(forResource: "audioBg", withExtension: "mp3")
        // now use declared path 'url' to initialize the player
    audio = AVPlayer.init(url: url!)
        // after initialization play audio its just like click on play button
    audio?.play()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    updateScore()
  }
  
  func updateScore() {
    FirebaseService.shared.getScore { score in
      DispatchQueue.main.async {
        self.score.text = "Score: \(score ?? 0)"
      }
    }
  }
  
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
  
  @IBAction func playVideoAction(_ sender: Any) {
    let avp = AVPlayerViewController()
    let urlFile = URL(fileURLWithPath: Bundle.main.path(forResource: "PlayChess", ofType: "mp4")!)
    avp.player = AVPlayer(url: urlFile)
    
    present(avp, animated: true){ [self] in
      self.audio?.pause()
      avp.player?.play()
      NotificationCenter.default.addObserver(self, selector: #selector(videoDidCancel), name: NSNotification.Name.kAVPlayerViewControllerDismissingNotification, object: nil)
     
    }
    
  }
  
  
  @objc private func videoDidCancel() {
    self.audio?.play()
  }
 
}
extension Notification.Name {
  static let kAVPlayerViewControllerDismissingNotification = Notification.Name.init("dismissing")
}
extension AVPlayerViewController {
    // override 'viewWillDisappear'
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // now, check that this ViewController is dismissing
        if self.isBeingDismissed == false {
            return
        }

        // and then , post a simple notification and observe & handle it, where & when you need to.....
        NotificationCenter.default.post(name: .kAVPlayerViewControllerDismissingNotification, object: nil)
    }
}
