//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Gabriele on 8/9/15.
//  Copyright (c) 2015 Ashley Donohoe. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        if var movieQuoteSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3")!){
            audioPlayer = AVAudioPlayer(contentsOfURL: movieQuoteSound, error: nil)
            audioPlayer.enableRate = true
            
        } else {
            println("The filePath is empty")
        }
    }
    
    @IBAction func playSlowAudio(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.rate = 0.5
        audioPlayer.play()

    }
}