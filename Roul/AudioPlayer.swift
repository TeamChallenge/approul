//
//  AudioPlayer.swift
//  Roul
//
//  Created by Thiago Vinhote on 23/02/17.
//  Copyright © 2017 Jerlilson Bezerra da Silva. All rights reserved.
//

import AVFoundation

class AudioPlayer: NSObject {
    
    private override init() {
        super.init()
    }
    
    static func configureAudio(withName name: String) -> AVAudioPlayer? {
        let myFilePathString = Bundle.main.path(forResource: name, ofType: "mp3")
        
        if let myFilePathString = myFilePathString{
            let myFilePathURL = URL(fileURLWithPath: myFilePathString)
            do{
                let myAudioPlayer = try AVAudioPlayer(contentsOf: myFilePathURL)
                if #available(tvOS 10.0, *) {
                    myAudioPlayer.volume = 0.01
                } else {
                    // Fallback on earlier versions
                    return nil
                }
                return myAudioPlayer
            }catch{
                return nil
            }
        }
        return nil
    }
    
}
