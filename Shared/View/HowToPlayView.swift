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

struct HowToPlayView: View {
    var body: some View {
        VStack{
            Text("📖 How to Play 📖")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
                .frame(maxWidth: .infinity, alignment: .center)
            
            
            Text("1. The game is played on a grid that's 3 squares by 3 squares.")
                .padding(10)
            Text("2.  You are X, your friend (or the computer in this case) is O. Players take turns putting their marks in empty squares.")
                .padding(10)
                .lineLimit(nil)
            Text("3. The first player to get 3 of her marks in a row (up, down, across, or diagonally) is the winner.")
                .padding(10)
            Text("4. When all 9 squares are full, the game is over. If no player has 3 marks in a row, the game ends in a tie.")
                .padding(10)
        } .onAppear(perform: {
            playSound(soundURL: "guidemusic", type: "mp3", isLoop: true)
    })
        .onDisappear(){
            audioPlayer?.stop()
        }
    }
}

struct HowToPlayView_Previews: PreviewProvider {
    static var previews: some View {
        HowToPlayView().preferredColorScheme(.dark)
    }
}
