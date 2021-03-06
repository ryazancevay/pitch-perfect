//
//  PlaySoundViewController.swift
//  Pitch Perfect
//
//  Created by Admin on 19.05.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {

    var audioPlayer: AVAudioPlayer!
    var receiveAudio: RecordedAudio!
    
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
/*        if var filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3"){
            var filePathUrl = NSURL.fileURLWithPath(filePath)

            
        } else {
            println("The filePath is empty")
        }
*/
        //println("Test")
        println(receiveAudio.filePathUrl)
        audioPlayer = AVAudioPlayer(contentsOfURL: receiveAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receiveAudio.filePathUrl, error: nil)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playSlowButton(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.rate = 0.5
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }

    @IBAction func playFastButton(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.rate = 1.5
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }

    @IBAction func stopButton(sender: UIButton) {
        audioPlayer.stop()
    }
    
    @IBAction func playChipmunkButton(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func playDarthvaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    func playAudioWithVariablePitch(pitch: Float){
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
