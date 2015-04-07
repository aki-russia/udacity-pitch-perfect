//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Dmitriy Kharchenko on 3/28/15.
//  Copyright (c) 2015 Dmitriy Kharchenko. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    var receivedAudio:RecordedAudio!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func playWithEffect(effect: AVAudioNode){
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        
        audioEngine.attachNode(audioPlayerNode)
        
        audioEngine.attachNode(effect)
        audioEngine.connect(audioPlayerNode, to: effect, format: nil)
        audioEngine.connect(effect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        audioPlayerNode.play()
    }
    
    
    func playWithPitch(rate: Float = 1, pitch: Float = 1){
        var changePitchEffect = AVAudioUnitTimePitch()
        
        changePitchEffect.rate = rate
        changePitchEffect.pitch = pitch
        playWithEffect(changePitchEffect)
    }
    
    func playWithReverb(wetDryMix: Float){
        var changeReverbEffect = AVAudioUnitReverb()
        changeReverbEffect.wetDryMix = wetDryMix
        playWithEffect(changeReverbEffect)
    }
    
    func playWithDistortion(wetDryMix: Float, preGain: Float = 100){
        var changeReverbEffect = AVAudioUnitDistortion()
        changeReverbEffect.wetDryMix = wetDryMix
        changeReverbEffect.preGain = preGain
        playWithEffect(changeReverbEffect)
    }
    

    @IBAction func playAsSnail(sender: UIButton) {
        playWithPitch(rate: 0.5)
        
    }
    
    @IBAction func playAsRabbit(sender: UIButton) {
        playWithPitch(rate: 2)
    }

    @IBAction func playAsRat(sender: UIButton) {
        playWithPitch(pitch: 1000)
        
    }
    
    @IBAction func playAsDevil(sender: UIButton) {
        playWithPitch(pitch: -1000)
    }
    
    @IBAction func playAsGhost(sender: UIButton) {
        playWithReverb(100)
    }
    
    @IBAction func playAsRadio(sender: UIButton) {
        playWithDistortion(100, preGain: 20)
    }
    @IBAction func stopAudioPlayer(sender: UIButton) {
        audioEngine.stop()
    }
}
