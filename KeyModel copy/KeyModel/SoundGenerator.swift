//
//  SoundGenerator.swift
//  KeyModel
//
//  Created by Arty Molina on 7/16/19.
//  Copyright © 2019 UCSC_CS115. All rights reserved.
//

import Foundation
import AudioKit

class SoundGenerator {
    
    let osc = AKOscillator()
    var envelope: AKAmplitudeEnvelope
    
    let attack = 0.01       //Envelope attack
    let decay = 0.1         //Envelope decay
    let sustain = 0.1       //Encelope sustain 
    let release = 0.3       //Envelope release
    let amplitude = 0.5     //Oscillator amplitude
    
    //Initializing new Sound Generator
    init() { 
        envelope = AKAmplitudeEnvelope(osc)                                 //Define new envelope for oscillator
        modEnvelope(attack: attack, decay: decay, sustain: sustain, release: release)   //Set envelope values
        startAudioKit()                                                     //Start AudioKit library
    }
    
    //Modifying envelope values
    func modEnvelope(attack: Double,decay: Double, sustain: Double, release: Double){
        envelope.attackDuration = attack
        envelope.decayDuration = decay
        envelope.sustainLevel = sustain
        envelope.releaseDuration = release
    }
    
    //Start AudioKit library
    func startAudioKit(){
        AudioKit.output = envelope              //Set envelope for AudioKit
        do {
            try AudioKit.start()                //Start AudioKit
        } catch {
            print("AudioKit did not start!")    //If fails, print error message
        }
    }
    
    //Making actual sound with a certain frequncy
    func startOsc(pitch: Double){
        osc.frequency = pitch                   //Set pitch (frequency)
        osc.amplitude = amplitude               //Set an constant amplitude
        osc.start()                             //Start making sound
        envelope.start()                        //Start envelope shaper
    }
    
    func stopOsc(){
        

        envelope.stop()                         //Stop envelope shaper
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}


