//
//  BoardView.swift
//  Chess
//

import UIKit

class BoardView: UIView {
  
  // MARK: - Properties
  private let viewModel: BoardViewModel
  
  // MARK: - init
  
  init(viewModel: BoardViewModel) {
    self.viewModel = viewModel
    super.init(frame: .zero)
    setup()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setup() {
    layer.borderColor = UIColor.black.cgColor
    layer.borderWidth = 1
  }
  
  // MARK: - Drawing
  
  override func draw(_ rect: CGRect) {
    
    let whiteColor = UIColor(red: 0.937, green: 0.851, blue: 0.718, alpha: 1)
    let blackColor = UIColor(red: 0.706, green: 0.533, blue: 0.400, alpha: 1)
    
    for i in 0..<64 {
      
      let gridX = i % 8
      let gridY = i / 8
      
      // Color
      let color = ((gridX + gridY) % 2 == 0) ? whiteColor : blackColor
      color.set()
      
      // Rect
      let squareSize = CGSize(width: bounds.size.width/8,
                              height: bounds.size.height/8)
      
      let rect = CGRect(x: CGFloat(gridX) * squareSize.width,
                        y: CGFloat(gridY) * squareSize.height,
                        width: squareSize.width,
                        height: squareSize.height)
      
      // Draw
      let path = UIBezierPath(rect: rect)
      path.fill()
      
    }
    
  }
  
  // MARK: - Touch Handling
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    let location = touches.first!.location(in: self)
    let boardIndex = boardIndexForLocation(location)
    viewModel.touchedSquareAtIndex(index: boardIndex)
  }
  
  override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    
  }
  
  func boardIndexForLocation(_ location: CGPoint) -> Int {
    var location = location
    location.y = bounds.size.height - location.y
    
    var gridX = Int(8.0 * location.x / bounds.size.width)
    var gridY = Int(8.0 * location.y / bounds.size.height)
    gridX = min(7, gridX)
    gridY = min(7, gridY)
    
    return gridX + (gridY*8)
  }
  
}
