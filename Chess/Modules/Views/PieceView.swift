//
//  PieceView.swift
//  Chess
//

import UIKit
import SwiftChess

class PieceView: UIView {
  
  public var piece: Piece {
    didSet {
      update()
    }
  }
  
  public var location: BoardLocation
  
  
  let imageView = UIImageView()
  
  var selected = false {
    didSet {
      update()
    }
  }
  
  init(piece: Piece, location: BoardLocation) {
    self.piece = piece
    self.location = location
    super.init(frame: CGRect.zero)
    imageView.contentMode = .scaleAspectFit
    addSubview(imageView)
    update()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder) is not implemented")
  }
  
  // MARK: - Layout
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    let margin = CGFloat(5)
    imageView.frame = CGRect(x: margin,
                             y: margin,
                             width: bounds.size.width - margin*2,
                             height: bounds.size.height - margin*2)
    
  }
  
  // MARK: - Update
  
  func update() {
    
    let imageName: String!
    
    switch (piece.type, piece.color) {
    case (.rook, .white):
      imageName = "WhiteRook"
    case (.knight, .white):
      imageName = "WhiteKnight"
    case (.bishop, .white):
      imageName = "WhiteBishop"
    case (.queen, .white):
      imageName = "WhiteQueen"
    case (.king, .white):
      imageName = "WhiteKing"
    case (.pawn, .white):
      imageName = "WhitePawn"
    case (.rook, .black):
      imageName = "BlackRook"
    case (.knight, .black):
      imageName = "BlackKnight"
    case (.bishop, .black):
      imageName = "BlackBishop"
    case (.queen, .black):
      imageName = "BlackQueen"
    case (.king, .black):
      imageName = "BlackKing"
    case (.pawn, .black):
      imageName = "BlackPawn"
    }
    
    let image = UIImage(named: imageName)
    assert(image != nil, "Missing image!")
    
    imageView.image = image
    
    backgroundColor = selected ? UIColor.gray : UIColor.clear
  }
  
}
