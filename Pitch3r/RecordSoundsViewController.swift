//
//  RecordSoundsViewController.swift
//  Pitch3r
//
//  Created by Sivcan Singh on 01/10/16.
//  Copyright © 2016 Sivcan Singh. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var startRecording: UIButton!
    @IBOutlet weak var stopRecording: UIButton!
    
    var audioRecorder : AVAudioRecorder!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        stopRecording.isEnabled = false
        self.title = "Pitch3r"
    }
    
    func recordEnabler(state: Bool) {
        startRecording.isEnabled = state
        stopRecording.isEnabled = !state
    }
    
    @IBAction func startRecord(_ sender: AnyObject) {
        recordingLabel.text = "Recording..."
        recordEnabler(state: false)
    
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURL(withPathComponents: pathArray)
        print(filePath!)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }

    
    @IBAction func stopRecord(_ sender: AnyObject) {
        recordingLabel.text = "Recording Ended."
        recordEnabler(state: true)
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        print("Audio recording did finish successfully!")
        if(flag) {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        }else {
            print("Failed to record audio!")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "stopRecording") {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! NSURL
            
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }

}

