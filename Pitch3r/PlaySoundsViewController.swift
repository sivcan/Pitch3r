//
//  PlaySoundsViewController.swift
//  Pitch3r
//
//  Created by Sivcan Singh on 01/10/16.
//  Copyright © 2016 Sivcan Singh. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController{
    
    @IBOutlet weak var snailButton : UIButton!
    @IBOutlet weak var rabbitButton : UIButton!
    @IBOutlet weak var darthVaderButton : UIButton!
    @IBOutlet weak var reverbButton : UIButton!
    @IBOutlet weak var chipmunkButton : UIButton!
    @IBOutlet weak var parrotButton : UIButton!
    @IBOutlet weak var stopButton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
    }
    
    var recordedAudioURL : NSURL!
    var audioFile : AVAudioFile!
    var audioEngine : AVAudioEngine!
    var audioPlayerNode : AVAudioPlayerNode!
    var stopTimer : Timer!
    
    enum ButtonType: Int{ case Echo = 0, Reverb, Chipmunk, Vader, Slow, Fast}
    
    @IBAction func playSoundForButton(sender: UIButton) {
        print("Play Button pressed!")
        switch(ButtonType(rawValue: sender.tag)!) {
        case .Slow:
            playSound(rate: 0.5)
        case .Fast :
            playSound(rate: 1.5)
        case .Chipmunk :
            playSound(pitch: 1000)
        case .Vader :
            playSound(pitch: -1000)
        case .Echo :
            playSound(echo: true)
        case .Reverb :
            playSound(reverb: true)
        }
        
        configureUI(playState: .Playing)
    }
    
    @IBAction func stopButtonPressed(sender: AnyObject) {
        print("Stopped button.")
        stopAudio()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI(playState: .NotPlaying)
    }
    
}

