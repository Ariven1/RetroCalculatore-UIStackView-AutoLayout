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

    var runningNumber = ""
    var currentOperation = Operators.Empty
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    
    enum Operators: String{
    
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    var player: AVAudioPlayer!
    @IBOutlet weak var displayLbl: UILabel!
    
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
        
        runningNumber += "\(sender.tag)"
        displayLbl.text = runningNumber
    }
    
    @IBAction func onDividePressed(sender: Any){
        
        processOperation(operation: .Divide)
    }

    @IBAction func onMultiplyPressed(sender: Any){
        
        processOperation(operation: .Multiply)
    }
    
    @IBAction func onSubstractPressed(sender: Any){
        
        processOperation(operation: .Subtract)
    }
    
    @IBAction func onAddPressed(sender: Any){
        
        processOperation(operation: .Add)
    }
    
    @IBAction func onEqualPressed(sender: Any){
        
        processOperation(operation: currentOperation)
    }
    
    @IBAction func clearPressed(_ sender: Any) {
        
        displayLbl.text = "0"
        runningNumber = ""
        currentOperation = Operators.Empty
        leftValStr = ""
        rightValStr = ""
    }
    
    
    func playSound(){
    
        if player.isPlaying{
            
            player.stop()
        }
        player.play()
    }
    
    func processOperation(operation: Operators){
    
        playSound()
        if currentOperation != Operators.Empty{
        
            // A user selected an operator, but then selected another operator without first entering a number
            if runningNumber != ""{
            
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operators.Multiply{
                
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                }
                else if currentOperation == Operators.Divide{
                
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                }
                else if currentOperation == Operators.Subtract{
                
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                }
                else if currentOperation == Operators.Add{
                
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }
                
                leftValStr = result
                displayLbl.text = result
            }
            currentOperation = operation
        }
        else{
        
            // This is the first time an operator has been pressed
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }
}

