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
import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(soundURL: String, type: String, isLoop: Bool){
    if let path = Bundle.main.path(forResource: soundURL, ofType: type){
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            
            audioPlayer?.play()
            if isLoop {
                audioPlayer?.numberOfLoops = -1
            }
        } catch {
            print("Can't play audio!")
        }
    }
}
