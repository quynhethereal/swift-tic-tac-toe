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

import SwiftUI

class CurrentPlayer: ObservableObject {
    @Published var score = 0
    @Published var name = ""
}

class BotPlayer: ObservableObject {
    @Published var score = 0
}

struct ContentView: View {
    @StateObject var currentPlayer = CurrentPlayer()
    @StateObject var botPlayer = BotPlayer()

    var body: some View {
        MenuView(currentPlayer: currentPlayer, botPlayer: botPlayer)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.light)
    }
}
