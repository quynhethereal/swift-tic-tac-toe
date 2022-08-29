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


struct RegistrationView: View {
    @State var isShown = true
    
    @State var clearInput = true
    
    @State private var text: String = ""
    
    @ObservedObject var botPlayer: BotPlayer
    
    @ObservedObject var currentPlayer: CurrentPlayer
        
    @Binding var scoreRecord: [LeaderboardRecord]
    
    var body: some View {
        NavigationView {
            VStack {
                
                Text("Enter your name to play... :)")
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                
                TextField("Enter your name...", text: $text)
                    .padding()
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                    
                    .onChange(of: text){ input in
                        if (input == ""){
                            isShown = true
                        }
                        if (input != ""){
                            currentPlayer.name = input
                            isShown = false
                        }
                    }
                    .onChange(of: clearInput){ _ in
                        self.text = ""
                    }
                
                Button(action: {
                    clearInput.toggle()
                }, label: {
                    NavigationLink(destination: GameGridView(botPlayer: botPlayer, currentPlayer: currentPlayer, scoreRecord: $scoreRecord ).navigationBarBackButtonHidden(true)) {
                         Text("Let's play!")
                     }
                })
                    .padding()
                    .background(Color("AppWhite"))
                    .foregroundColor(Color("AppBlack"))
                    .clipShape(Capsule())
                    .opacity(isShown ? 0 : 1)
                
                Spacer()
            }
            .padding()
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    
    static var previews: some View {
        let currentPlayer = CurrentPlayer()
        let botPlayer = BotPlayer()
        
        let score: [LeaderboardRecord] = [
            .init(name: "Mario", score: 12)
        ]
        
        RegistrationView( botPlayer: botPlayer,currentPlayer: currentPlayer, scoreRecord: .constant(score)).preferredColorScheme(.dark)
    }
}
