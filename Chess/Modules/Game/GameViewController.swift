//
//  GameViewController.swift
//  Chess
//

import UIKit
import SnapKit
import SwiftChess
import SwiftConfettiView
import AVFoundation

class GameViewController: UIViewController {
  var audio: AVPlayer!
  var confettiView: SwiftConfettiView!
  private let viewModel: GameViewModel
  
  private lazy var boardView = BoardView(viewModel: viewModel.boardViewModel)
  
  var pieceViews = [PieceView]()
  
  var selectedIndex: Int? {
    didSet {
      updatePieceViewSelectedStates()
    }
  }
  
  var promotionSelectionViewController: PromotionSelectionViewController?
  var hasMadeInitialAppearance = false
  
  init(viewModel: GameViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .black
    view.addSubview(boardView)
    boardView.snp.makeConstraints { make in
      make.leading.trailing.centerY.equalToSuperview()
      make.height.equalTo(boardView.snp.width)
    }
    
    bindToViewModel()
    viewModel.delegate = self
    
    viewModel.addPieceViews()
    
   
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
  }
  
  private func bindToViewModel() {
    viewModel.didTouchAtIndex = { [unowned self] index in
      self.movePiece(index: index)
    }
    
    viewModel.didGetPiece = { [unowned self] x, y, piece in
      addPieceView(at: x, y: y, piece: piece)
    }
  }
  
  // MARK: - Manage Piece Views
  
  func addPieceView(at x: Int, y: Int, piece: Piece) {
    
    let location = BoardLocation(x: x, y: y)
    
    let pieceView = PieceView(piece: piece, location: location)
    boardView.addSubview(pieceView)
    pieceViews.append(pieceView)
  }
  
  func removePieceView(withTag tag: Int) {
    
    if let pieceView = pieceViewWithTag(tag) {
      removePieceView(pieceView: pieceView)
    }
  }
  
  func removePieceView(pieceView: PieceView) {
    
    if let index = pieceViews.firstIndex(of: pieceView) {
      pieceViews.remove(at: index)
    }
    
    if pieceView.superview != nil {
      pieceView.removeFromSuperview()
    }
  }
  
  func updatePieceViewSelectedStates() {
    
    for pieceView in pieceViews {
      pieceView.selected = (pieceView.location.index == selectedIndex)
    }
  }
  
  func pieceViewWithTag(_ tag: Int) -> PieceView? {
    return pieceViews.first { $0.piece.tag == tag }
  }
  
  private func movePiece(index: Int) {
    guard let player = viewModel.game.currentPlayer as? Human else { return }
    
    let location = BoardLocation(index: index)
    
    if let selectedIndex = selectedIndex {
      if location == BoardLocation(index: selectedIndex) {
        self.selectedIndex = nil
        return
      }
    }
    
    if player.occupiesSquare(at: location) {
      selectedIndex = index
    }
    
    if let selectedIndex = selectedIndex {
      do {
        try player.movePiece(from: BoardLocation(index: selectedIndex),
                             to: location)
        
      } catch Player.MoveError.pieceUnableToMoveToLocation {
        print("Piece is unable to move to this location")
        
      } catch Player.MoveError.cannotMoveInToCheck {
        print("Player cannot move in to check")
        showAlert(title: "", message: "Player cannot move in to check")
        
      } catch Player.MoveError.playerMustMoveOutOfCheck {
        print("Player must move out of check")
        showAlert(title: "", message: "Player must move out of check")
        
      } catch {
        print("Something went wrong!")
        return
      }
    }
  }
  
  // MARK: - Layout
  
  override func viewDidLayoutSubviews() {
    
    // Layout pieces
    for pieceView in pieceViews {
      
      let gridX = pieceView.location.x
      let gridY = 7 - pieceView.location.y
      
      let width = boardView.bounds.size.width / 8
      let height = boardView.bounds.size.height / 8
      
      pieceView.frame = CGRect(x: CGFloat(gridX) * width,
                               y: CGFloat(gridY) * height,
                               width: width,
                               height: height)
    }
    
    if let promotionSelectionViewController = promotionSelectionViewController {
      let margin = CGFloat(40)
      promotionSelectionViewController.view.frame = CGRect(x: margin,
                                                           y: margin,
                                                           width: view.bounds.size.width - (margin*2),
                                                           height: view.bounds.size.height - (margin*2))
    }
  }
  
  // MARK: - Alerts
  
  func showAlert(title: String, message: String) {
    
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    
    alertController.addAction(okAction)
    alertController.addAction(cancelAction)
    
    present(alertController, animated: true, completion: nil)
  }
  

}

// MARK: - GameViewModelDelegate

extension GameViewController: GameViewModelDelegate {
  func gameDidChangeCurrentPlayer(game: Game) {
    // Do nothing
  }
  
  
  func gameWillBeginUpdates(game: Game) {
    // Do nothing
  }
  
  func gameDidAddPiece(game: Game) {
    // Do nothing
  }
  
  func gameDidMovePiece(game: Game, piece: Piece, toLocation: BoardLocation) {
    
    guard let pieceView = pieceViewWithTag(piece.tag) else {
      return
    }
    
    pieceView.location = toLocation
    
    view.setNeedsLayout()
    
    UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
      self.view.layoutIfNeeded()
    }, completion: nil)
    
  }
  
  func gameDidRemovePiece(game: Game, piece: Piece, location: BoardLocation) {
    
    guard let pieceView = pieceViewWithTag(piece.tag) else {
      return
    }
    
    UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
      pieceView.alpha = 0
    }, completion: { (finished: Bool) in
      self.removePieceView(withTag: piece.tag)
    })
    
  }
  
  func gameDidTransformPiece(game: Game, piece: Piece, location: BoardLocation) {
    
    guard let pieceView = pieceViewWithTag(piece.tag) else {
      return
    }
    
    pieceView.piece = piece
  }
  
  func gameDidEndUpdates(game: Game) {
  }
  
  func gameWonByPlayer(game: Game, player: Player) {
    let url = Bundle.main.url(forResource: "audioWin", withExtension: "mp3")
        // now use declared path 'url' to initialize the player
    audio = AVPlayer.init(url: url!)
        // after initialization play audio its just like click on play button
    audio?.play()
    let colorName = player.color.string
    
    let title = "Checkmate!"
    let message = "\(colorName.capitalized) wins!"
    confettiView = SwiftConfettiView(frame: self.view.bounds)
    
    // Set colors (default colors are red, green and blue)
    confettiView.colors = [UIColor(red:0.95, green:0.40, blue:0.27, alpha:1.0),
                           UIColor(red:1.00, green:0.78, blue:0.36, alpha:1.0),
                           UIColor(red:0.48, green:0.78, blue:0.64, alpha:1.0),
                           UIColor(red:0.30, green:0.76, blue:0.85, alpha:1.0),
                           UIColor(red:0.58, green:0.39, blue:0.55, alpha:1.0)]
    
    // Set intensity (from 0 - 1, default intensity is 0.5)
    confettiView.intensity = 1
    
    // Set type
    confettiView.type = .confetti
    
    // For custom image
    // confettiView.type = .Image(UIImage(named: "diamond")!)
    
    // Add subview
    view.addSubview(confettiView)
    for _ in 0...5{
      confettiView.startConfetti()
    }
    
    showAlert(title: title, message: message)
  }
  
  func gameEndedInStaleMate(game: Game) {
    showAlert(title: "Stalemate", message: "Player cannot move")
  }
  
  func promotedTypeForPawn(location: BoardLocation,
                           player: Human,
                           possiblePromotions: [Piece.PieceType],
                           callback: @escaping (Piece.PieceType) -> Void) {
    
    boardView.isUserInteractionEnabled = false
    let viewController =
    PromotionSelectionViewController.customInit(pawnLocation: location,
                                                possibleTypes: possiblePromotions) {
      
      self.promotionSelectionViewController?.view.removeFromSuperview()
      self.promotionSelectionViewController?.removeFromParent()
      self.boardView.isUserInteractionEnabled = true
      callback($0)
    }
    
    view.addSubview(viewController.view)
    addChild(viewController)
    promotionSelectionViewController = viewController
  }
  
}
