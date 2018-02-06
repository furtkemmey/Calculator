//
//  ViewController.swift
//  Calculator
//
//  Created by HsuKaiChieh on 04/02/2018.
//  Copyright © 2018 HKC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var display: UILabel!
    var userIsinTheMiddleOfTyping = false
    
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsinTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        } else {
            display.text = digit
            userIsinTheMiddleOfTyping = true
        }
    }
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
            
        }
    }
    private var brain = CalculatorBrain()
    
    @IBAction func performOperation(_ sender: UIButton) {
        if userIsinTheMiddleOfTyping {
            brain.setOperand(displayValue)
            userIsinTheMiddleOfTyping = false
        }
        if let mathematiucalSymbol = sender.currentTitle {
            brain.performOperation(mathematiucalSymbol)
        }
        if let result = brain.result {
            displayValue = result
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

