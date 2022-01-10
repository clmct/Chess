//
//  BoardViewModel.swift
//  Chess
//

import Foundation

protocol BoardViewModelDelegate: AnyObject {
  func touchedSquareAtIndex(_ viewModel: BoardViewModel, index: Int)
}

class BoardViewModel {
  weak var delegate: BoardViewModelDelegate?
  
  func touchedSquareAtIndex(index: Int) {
    delegate?.touchedSquareAtIndex(self, index: index)
  }
}
