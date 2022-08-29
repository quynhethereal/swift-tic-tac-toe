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

struct GameGridView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var botPlayer: BotPlayer
    
    @State var moves : [Move?] = Array(repeating: nil, count: 9)
    
    @State var gameEnded = false
    
    @State private var playerHuman = Player(playerType: PlayerType.human, isPlaying: true)
    
    @State private var playerBot = Player(playerType: PlayerType.bot, isPlaying: false)
    
    @ObservedObject var currentPlayer: CurrentPlayer
    
    @Binding var scoreRecord: [LeaderboardRecord]
    
    @State var winner: String = ""
    
    @State var animate = 1.0
        
    var body: some View {
        let columns = [GridItem(.flexible()),     GridItem(.flexible()),GridItem(.flexible())]
        VStack{
            HStack {
                VStack{
                    Text(" Player \(currentPlayer.name)")
                        .fontWeight(.bold)
                        .font(.title)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .center)
                        .multilineTextAlignment(.center)
                    //                        .padding()
                    
                    Text("\(currentPlayer.score)")
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                
                VStack{
                    
                    Text("Player Bot")
                        .fontWeight(.bold)
                        .font(.title)
                        .padding()
                        .frame(alignment: .center)
                    
                    Text("\(botPlayer.score)")
                        .font(.title)
                        .frame(alignment: .center)
                    
                }
            }
            
            LazyVGrid(columns: columns, spacing: 20) {
                
                ForEach(0..<9, id: \.self){ index in
                    ZStack{
                    
                        
                        Color("AppWhite")
                            .frame(width: 100, height: 100)
                            .cornerRadius(5)
                        
                        Text(moves[index]?.symbol ?? "")
                            .foregroundColor(Color("AppSymbol"))
                            .fontWeight(.heavy)
                            .font(.largeTitle)
                            .scaleEffect(2.0)
                        
                    }
                    .onTapGesture(perform: {
                        
                        withAnimation(Animation.easeIn(duration: 0.5)){
                            // prevent toggling on played square
                            if moves[index] != nil { return }
                            
                            moves[index] = Move(player: playerHuman,index: index)
                            
                            playSound(soundURL: "gamemove", type: "wav", isLoop: false)
                            
                            
                            if (checkDraw(in: moves) || checkMoves(symbol: "X")){
                                return
                            }
                                                    
                            let botMove = getBotMove(in: moves)
                            
                            moves[botMove] = Move(player: playerBot, index: botMove)
                            
                            
                        }
                    })
                    .alert(isPresented: $gameEnded, content: {
                        Alert(title: Text("\(alertMessage())"), primaryButton: .default(Text("Play Again")) {
                            
                            moves.removeAll()
                            moves =  Array(repeating: nil, count: 9)
                            winner = ""
                            
                        },
                            secondaryButton: .destructive(Text("End Game"), action: {
                            
                            if (botPlayer.score > currentPlayer.score && (botPlayer.score != 0 || currentPlayer.score != 0)){
                                
                                let record = LeaderboardRecord(name: "Bot", score: botPlayer.score)
                                scoreRecord.append(record)
                                
                            } else if (botPlayer.score < currentPlayer.score && (botPlayer.score != 0 || currentPlayer.score != 0)) {
                                let record = LeaderboardRecord(name: currentPlayer.name, score: currentPlayer.score)
                                scoreRecord.append(record)
                            }
                            moves.removeAll()
                            moves =  Array(repeating: nil, count: 9)
                            currentPlayer.score = 0
                            botPlayer.score = 0
                            winner = ""
                            dismiss()
                        }))
                    })
                }.onChange(of: moves) { newValue in
                    checkWinner()
//                    determineMoves(symbol: "O")
                }

            }.padding(.bottom, 40)
            
            Spacer()
        }
    }
    
    func checkWinner(){
        if checkMoves(symbol: "X"){
            gameEnded = true
            currentPlayer.score += 1
            playSound(soundURL: "gamewin", type: "wav", isLoop: false)
            winner = currentPlayer.name
            return
        }
        
        if checkMoves(symbol: "O"){
            gameEnded = true
            botPlayer.score += 1
            playSound(soundURL: "gameover", type: "wav", isLoop: false)
            winner = "Bot"
            return
        }
        else {
            if checkDraw(in: moves){
                gameEnded = true
                playSound(soundURL: "gamedraw", type: "wav", isLoop: false)
                winner = "@@Draw@@"
                return
            }
        }
    }
    
    func checkDraw(in moves: [Move?]) -> Bool {
        return moves.compactMap { val in
            return val
        }.count == 9
    }
    
    func getBotMove(in moves: [Move?]) -> Int {
        
        let computerMoves = moves.compactMap {$0}.filter { $0.symbol == "0" }.map { $0.index }
        
        let humanMoves = moves.compactMap {$0}.filter { $0.symbol == "X" }.map { $0.index }
        
        let winMoves: Set<Set<Int>> =  [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
        
        for winMove in winMoves {
            let result = winMove.subtracting(computerMoves)
            
            let humanResult = winMove.subtracting(humanMoves)
            
            if result.count == 1 {
                if moves[result.first!] == nil {
                    return result.first!
                }
            }
            
            if humanResult.count == 1{
                if moves[humanResult.first!] == nil {
                    return humanResult.first!
                }
            }
        }
        
        
        var botMove = Int.random(in: 0..<9)
        
        while (moves[botMove] != nil){
            botMove = Int.random(in: 0..<9)
        }
        return botMove
    }
    
    func checkMoves(symbol: String) -> Bool{
        for i in 0...2 {
            if moves[i]?.symbol == symbol && moves[i + 3]?.symbol == symbol && moves[i + 6]?.symbol == symbol{
                return true
            }
        }
        
        if moves[0]?.symbol == symbol && moves[4]?.symbol == symbol && moves[8]?.symbol == symbol {
            return true
        }
        
        for i in stride(from: 0, to: 9, by: 3){
            if moves[i]?.symbol == symbol && moves[i + 1]?.symbol == symbol && moves[i + 2]?.symbol == symbol{
                return true
            }
        }
        
        if moves[2]?.symbol == symbol && moves[4]?.symbol == symbol && moves[6]?.symbol == symbol {
            return true
        }
        return false
    }
    
//    func determineMoves(symbol: String) -> Int{
//        let symbol = "O"
//
//        let computerMoves = moves.compactMap {$0}.filter { $0.symbol == symbol }.map { $0.index }
//
//        let winMoves: Set<Set<Int>> =  [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
//
//        for winMove in winMoves {
//            let result = winMove.subtracting(computerMoves)
//
//            if result.count == 1 {
//                if moves[result.first!] == nil {
//                    return result.first!
//                }
//            }
//        }
////
//        print(computerMoves)
//    }
    
    func alertMessage() -> String {
        if winner == currentPlayer.name {
            return "You have won!"
        } else if (winner == "Bot") {
            return "Bot have won!"
        } else if (winner == "@@Draw@@"){
            return "It is a draw!"
        }
        return ""
    }
}

struct GameGridView_Previews: PreviewProvider {
    static var previews: some View {
        let currentPlayer = CurrentPlayer()
        let botPlayer = BotPlayer()
        
        let score: [LeaderboardRecord] = [
            .init(name: "Mario", score: 12)
        ]
        
        GameGridView(botPlayer: botPlayer, currentPlayer: currentPlayer, scoreRecord: .constant(score)).preferredColorScheme(.dark).previewDevice(PreviewDevice(rawValue: "iPhone 13"))
    }
}
