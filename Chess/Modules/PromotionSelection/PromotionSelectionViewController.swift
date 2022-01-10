//
//  PromotionSelectionViewController.swift
//  Chess
//

import UIKit
import SwiftChess

class PromotionSelectionViewController: UIViewController {
  
  var pawnLocation: BoardLocation!
  var possibleTypes: [Piece.PieceType]!
  var callback: ((Piece.PieceType) -> Void)!
  var buttons = [UIButton]()
  
  public static func customInit(pawnLocation: BoardLocation,
                                possibleTypes: [Piece.PieceType],
                                callback: @escaping (Piece.PieceType) -> Void)
  -> PromotionSelectionViewController {
    let viewController = PromotionSelectionViewController()
    viewController.pawnLocation = pawnLocation
    viewController.possibleTypes = possibleTypes
    viewController.callback = callback
    return viewController
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = UIColor.gray
    view.layer.cornerRadius = 7
    
    for type in possibleTypes {
      let typeString = stringFromPieceType(pieceType: type)
      let button = UIButton(type: .system)
      button.setTitle(typeString, for: .normal)
      button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
      view.addSubview(button)
      buttons.append(button)
    }
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    let buttonHeight = view.bounds.size.height / CGFloat(buttons.count)
    for (index, button) in buttons.enumerated() {
      button.frame = CGRect(x: 0,
                            y: CGFloat(index) * buttonHeight,
                            width: view.bounds.size.width,
                            height: buttonHeight)
    }
  }
  
  
  @objc func buttonPressed(sender: UIButton) {
    
    let index = buttons.firstIndex(of: sender)!
    let chosenType = possibleTypes![index]
    callback(chosenType)
  }
  
  func stringFromPieceType(pieceType: Piece.PieceType) -> String {
    switch pieceType {
    case .pawn: return "Pawn"
    case .rook: return "Rook"
    case .knight: return "Knight"
    case .bishop: return "Bishop"
    case .queen: return "Queen"
    case .king: return "King"
    }
  }
}
