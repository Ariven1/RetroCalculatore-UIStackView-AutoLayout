//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Ariven on 03/09/17.
//  Copyright © 2017 Ariven. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var player: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do{
        
            try player = AVAudioPlayer(contentsOf: soundURL)
            player.prepareToPlay()
        }
        catch let err as NSError{
        
            print(err.debugDescription)
        }
    }

    @IBAction func numberPressed(sender: UIButton){
    
        playSound()
    }

    func playSound(){
    
        if player.isPlaying{
            
            player.stop()
        }
        player.play()
    }
}

