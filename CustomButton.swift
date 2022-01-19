//
//  CustomButton.swift
//  Chess
//
//  Created by Тимофей Веретнов on 19.01.2022.
//
import UIKit
import Foundation
class CustomButton : UIButton{
    init(){
        super.init(frame: CGRect(x: 0, y: 0, width: 343, height: 56))
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    private func setup(){
      backgroundColor = .white
        layer.cornerRadius = 15
        
        
        
        layer.shadowColor = UIColor(named: "ShadowForButton")?.cgColor
        layer.shadowRadius = 5
        
      layer.shadowOpacity = 0.5
        layer.shadowOffset  = CGSize(width: 0, height: 2)
        
    }
    
    
}
