/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Le Dinh Ngoc Quynh
  ID: s3791159
  Created  date: dd/mm/yyyy (e.g. 19/08/2022)
  Last modified: dd/mm/yyyy (e.g. 28/08/2022)
  Acknowledgement: Acknowledge the resources that you use here.
*/

import Foundation

struct Move: Identifiable, Equatable{
    static func == (lhs: Move, rhs: Move) -> Bool {
        lhs.symbol == rhs.symbol
    }
    
    
    let player: Player
    
    var id = UUID()
    var symbol: String {
        return player.isPlaying ? "X" : "O"
    }
    var index: Int
}
