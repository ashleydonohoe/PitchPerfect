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
    
    var receivedAudio = RecordedAudio()
    
    var audioEngine:AVAudioEngine!
    
    var audioFile:AVAudioFile!
    
    
    override func viewDidLoad() {
    /*    if var movieQuoteSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3")!){
            
        } else {
            println("The filePath is empty")
        } */
        
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathURL, error: nil)
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathURL, error: nil)
    }
    
    
    @IBAction func playSlowAudio(sender: UIButton) {
        audioPlayer.rate = 0.5
        playAudio()

    }
    
    @IBAction func playFastAudio(sender: UIButton) {
        audioPlayer.rate = 2.0
        playAudio()
    }
    
  
    @IBAction func playChipmunkAudio(sender: UIButton) {
        
        playAudioWithVariablePitch(1000)
    }
    
    
    @IBAction func playDarthVaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    func playAudioWithVariablePitch(pitch: Float) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    @IBAction func stopAudio(sender: UIButton) {
        audioPlayer.stop()
    }
    
    func playAudio() {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
}