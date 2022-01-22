//
//  FirebaseService.swift
//  Chess
//

import UIKit
import Firebase
import FirebaseFirestore

class FirebaseService {
  
  static var shared = FirebaseService()
  private let myId = UIDevice.current.identifierForVendor?.uuidString
  
  private let db = Firestore.firestore().collection("Game")
  
  func setScore(value: Int) {
    guard let myId = myId else { return }
    db.document("Results").setData([myId: value], merge: true)
  }
 
  func getScore(completion: @escaping (Int?) -> Void) {
    db.document("Results").getDocument { document, _ in
      guard let document = document,
            document.exists,
            let data = document.data(),
            let myId = self.myId else {
              completion(nil)
              return
            }
      let score = data[myId] as? Int
      completion(score)
    }
  }
}
