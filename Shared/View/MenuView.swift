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

struct MenuView: View {
    
    @ObservedObject var currentPlayer: CurrentPlayer
    
    @ObservedObject var botPlayer: BotPlayer
        
    @State var scoreRecord = [LeaderboardRecord]()

    
    var body: some View {
        NavigationView {
            VStack{
                HeaderView().edgesIgnoringSafeArea(.top)
                VStack{
                    List {
                        NavigationLink(destination: RegistrationView(botPlayer: botPlayer, currentPlayer: currentPlayer, scoreRecord: $scoreRecord)){
                            Text("🎮 Play Tic-Tac-Toe")
                        }
                        NavigationLink(destination: HowToPlayView()){
                            Text("❓ How to play")
                        }
                        NavigationLink(destination: LeaderboardView(leaderboardLog: $scoreRecord)){
                            Text("📊 Leadership board")
                        }
                    }
                }
            }
        }
    }
}


struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        let currentPlayer = CurrentPlayer()
        let botPlayer = BotPlayer()
        
        MenuView( currentPlayer: currentPlayer,botPlayer: botPlayer ).preferredColorScheme(.dark)
    }
}
