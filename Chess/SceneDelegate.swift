//
//  SceneDelegate.swift
//  Chess
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  var window: UIWindow?
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let scene = (scene as? UIWindowScene) else { return }
    let window = UIWindow(windowScene: scene)
    let vc = ViewController()
    let nc = UINavigationController(rootViewController: vc)
    window.rootViewController = nc
    window.makeKeyAndVisible()
    self.window = window
  }
}

