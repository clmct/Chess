//
//  Animation.swift
//  Chess
//

import UIKit

class Animation {
  
  var window: UIWindow
  
  init(window: UIWindow) {
    self.window = window
  }
  
  lazy var snowCell: CAEmitterCell = {
    var cell = CAEmitterCell()
    cell.contents = UIImage(named: "BlackKnight1")?.cgImage
    
    cell.scale = 0.20
    cell.scaleRange = 0
    cell.scaleSpeed = 0.02
    cell.emissionRange = CGFloat.pi * 2
    cell.lifetime = 3.0
    cell.lifetimeRange = 1
    cell.birthRate = 15
    cell.velocity = -30
    cell.velocityRange = -20
    cell.alphaSpeed = -0.4
    cell.yAcceleration = 70
    cell.xAcceleration = 10
    cell.zAcceleration = 30
    cell.spin = 1
    cell.spinRange = 2
    
    return cell
  }()
  
  lazy var snowCell2: CAEmitterCell = {
    var cell = CAEmitterCell()
    cell.contents = UIImage(named: "bk1")?.cgImage
    
    cell.scale = 0.05
    cell.scaleRange = 0
    cell.scaleSpeed = 0.02
    cell.emissionRange = CGFloat.pi * 2
    cell.lifetime = 4.0
    cell.lifetimeRange = 1
    cell.birthRate = 15
    cell.velocity = -30
    cell.velocityRange = -20
    cell.alphaSpeed = -0.4
    cell.yAcceleration = 70
    cell.xAcceleration = 10
    cell.zAcceleration = 30
    cell.spin = 1
    cell.spinRange = 2
    
    return cell
  }()
  
  lazy var layer: CAEmitterLayer = {
    let layer = CAEmitterLayer()
    layer.emitterPosition = CGPoint(x: window.bounds.width / 2.0, y: 200)
    layer.emitterSize = CGSize(width: 100, height: 100)
    layer.emitterShape = .circle
    layer.beginTime = CACurrentMediaTime()
    layer.emitterCells = [snowCell, snowCell2]
    layer.lifetime = 0
    self.window.layer.addSublayer(layer)
    return layer
  }()
  
  public func animate(gesture: UILongPressGestureRecognizer) {

    let state = gesture.state
    let location = gesture.location(in: window)
    self.layer.emitterPosition = CGPoint(x: location.x, y: location.y )
    
    switch state {
    case .began:
      layer.lifetime = 1
    case .changed:
      layer.lifetime = 1
    default:
      layer.lifetime = 0
    }
    
  }
  
}
