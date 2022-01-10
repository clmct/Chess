//
//  GameViewModel.swift
//  Chess
//

import Foundation
import SwiftChess

protocol GameViewModelDelegate: AnyObject {
  // State changes
  func gameDidChangeCurrentPlayer(game: Game)
  func gameWonByPlayer(game: Game, player: Player)
  func gameEndedInStaleMate(game: Game)
  
  // Piece adding / removing / modifying
  
  // A new piece was added to the board
  func gameDidAddPiece(game: Game)
  // A piece was removed from the board
  func gameDidRemovePiece(game: Game, piece: Piece, location: BoardLocation)
  // A piece was moved on the board
  func gameDidMovePiece(game: Game, piece: Piece, toLocation: BoardLocation)
  // A piece was transformed (eg. pawn was promoted to another piece)
  func gameDidTransformPiece(game: Game, piece: Piece, location: BoardLocation)
  // Updates will end)
  func gameDidEndUpdates(game: Game)
  
  // Callbacks from player
  func promotedTypeForPawn(location: BoardLocation,
                           player: Human,
                           possiblePromotions: [Piece.PieceType],
                           callback: @escaping (Piece.PieceType) -> Void )
}

class GameViewModel {
  weak var delegate: GameViewModelDelegate?
  
  var didTouchAtIndex: ((Int) -> Void)?
  var didGetPiece: ((_ x: Int, _ y: Int, _ piece: Piece) -> Void)?
  let game: Game!
  
  lazy var boardViewModel: BoardViewModel = makeBoardViewModel()
  
  init(game: Game) {
    self.game = game
    game.delegate = self
  }
  
  func addPieceViews() {
    for location in BoardLocation.all {
      guard let piece = game.board.getPiece(at: location) else { continue }
      didGetPiece?(location.x, location.y, piece)
    }
  }
  
  private func makeBoardViewModel() -> BoardViewModel {
    self.boardViewModel = BoardViewModel()
    boardViewModel.delegate = self
    return boardViewModel
  }
  
  
  
}

extension GameViewModel: BoardViewModelDelegate {
  func touchedSquareAtIndex(_ viewModel: BoardViewModel, index: Int) {
    didTouchAtIndex?(index)
  }
}

extension GameViewModel: GameDelegate {
  func gameDidChangeCurrentPlayer(game: Game) {
    delegate?.gameDidChangeCurrentPlayer(game: game)
  }
  
  func gameWonByPlayer(game: Game, player: Player) {
    delegate?.gameWonByPlayer(game: game, player: player)
  }
  
  func gameEndedInStaleMate(game: Game) {
    delegate?.gameEndedInStaleMate(game: game)
  }
  
  func gameWillBeginUpdates(game: Game) {
    delegate?.gameDidEndUpdates(game: game)
  }
  
  func gameDidAddPiece(game: Game) {
    delegate?.gameDidAddPiece(game: game)
  }
  
  func gameDidRemovePiece(game: Game, piece: Piece, location: BoardLocation) {
    delegate?.gameDidRemovePiece(game: game, piece: piece, location: location)
  }
  
  func gameDidMovePiece(game: Game, piece: Piece, toLocation: BoardLocation) {
    delegate?.gameDidMovePiece(game: game, piece: piece, toLocation: toLocation)
  }
  
  func gameDidTransformPiece(game: Game, piece: Piece, location: BoardLocation) {
    delegate?.gameDidTransformPiece(game: game, piece: piece, location: location)
  }
  
  func gameDidEndUpdates(game: Game) {
    delegate?.gameDidEndUpdates(game: game)
  }
  
  func promotedTypeForPawn(location: BoardLocation, player: Human, possiblePromotions: [Piece.PieceType], callback: @escaping (Piece.PieceType) -> Void) {
    delegate?.promotedTypeForPawn(location: location, player: player, possiblePromotions: possiblePromotions, callback: callback)
  }
}
