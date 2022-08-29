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

struct HeaderView: View {
    var body: some View {
        GeometryReader{ proxy in
                    let size = proxy.size
                    let height = 280.00
                    
                    Image("tictactoe").resizable().aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: height, alignment: .top).cornerRadius(5)
                        .overlay(content: {
                            ZStack(alignment: .bottom) {
                                
                                // smoky effect
                                LinearGradient(colors: [.clear,.black.opacity(0.7)], startPoint: .top, endPoint: .bottom)
                                
                                VStack(alignment: .leading, spacing: 5) {
                                    Text("assignment two").font(.callout).foregroundColor(.white)
                                    
                                    HStack(alignment: .bottom, spacing: 20){
                                        Text("Tic-Tac-Toe Game ").font(.title.bold()).foregroundColor(.white)
                                        
                                    }
                                    
                                }.padding(.bottom,10)
                                    .padding(.horizontal)
                                    .frame(maxWidth: .infinity, alignment: .leading )
                            }
                        }).cornerRadius(5)
                }.frame(height: 130)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
