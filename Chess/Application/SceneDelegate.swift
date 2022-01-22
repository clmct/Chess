//
//  SceneDelegate.swift
//  Chess
//

import UIKit
import SwiftChess

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  var window: UIWindow?
  lazy var animation = Animation(window: window ?? UIWindow())
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let scene = (scene as? UIWindowScene) else { return }
    let window = UIWindow(windowScene: scene)
    
    let navigationControlelr = UINavigationController(rootViewController: MenuViewController.initWithSB())
    window.rootViewController = navigationControlelr
    window.makeKeyAndVisible()
    self.window = window
    
    let gest = UILongPressGestureRecognizer(target: self, action: #selector(gestureFunc(gesture:)))
        window.addGestureRecognizer(gest)
  }
  
  @objc func gestureFunc(gesture: UILongPressGestureRecognizer) {
     animation.animate(gesture: gesture)
   }
}
