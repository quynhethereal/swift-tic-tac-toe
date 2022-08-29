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

struct LeaderboardView: View {
    
    @Binding var leaderboardLog: [LeaderboardRecord]
    
    @State var isPlayingMusic: Bool = true
        
    var body: some View {
        
        
        VStack(){
            
            Text("✨Leaderboard✨")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
                .frame(maxWidth: .infinity, alignment: .center)
            
            ScrollView {
                
                if (leaderboardLog.count == 0){
                    Text("Such empty... Why don't you go play first?").opacity(90)
                }
                
                ForEach(leaderboardLog, id: \.self) { i in
                    VStack{
                        HStack{
                            Text("\(i.name)")
                                .padding(5)
                                .font(.title2)
                            
                            Spacer()
                            
                            Text("\(i.score)")
                                .padding(5)
                                .font(.title2)
                        }
                    }
                }
            }.padding()
            Spacer()
        }.padding(.bottom, 5)
        .onAppear(perform: {
            playSound(soundURL: "backgroundmusic", type: "mp3", isLoop: true)
        })
        .onDisappear() {
            audioPlayer?.stop()
        }
    }
}

struct LeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        
        let score: [LeaderboardRecord] = [
            .init(name: "Mario", score: 12),
            .init(name: "Mario", score: 12),
            .init(name: "Mario", score: 12),
            .init(name: "Mario", score: 12),
            .init(name: "Mario", score: 12),
            .init(name: "Mario", score: 12),
            .init(name: "Mario", score: 12),
            .init(name: "Mario", score: 12),
            .init(name: "Mario", score: 12),
            .init(name: "Mario", score: 12),
            .init(name: "Mario", score: 12),
        ]
        
        LeaderboardView(leaderboardLog: .constant(score) ).preferredColorScheme(.light)
    }
}
