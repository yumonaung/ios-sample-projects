//
//  ViewController.swift
//  Tipsy
//
//  Created by Yu Mon Aung on 2021/03/23.
//  Copyright © 2021 example.yu.mon.tips. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var zeroPctButton: UIButton!
    
    @IBOutlet weak var billTextField: UITextField!
    
    @IBOutlet weak var tenPctButton: UIButton!
    
    @IBOutlet weak var twentyPctButton: UIButton!
    
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var percentage = 0.0
    var numberOfPeople = 2
    var billTotal = 0.0
    var finalResult = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func tipChanged(_ sender: UIButton) {
        print(sender.currentTitle!)
        billTextField.endEditing(true)
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        sender.isSelected = true
        let tip = Double(String(sender.currentTitle!.dropLast()))
        percentage = tip! / 100
  
    }
    
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        print("Stepper value : \(sender.value)")
        
        splitNumberLabel.text = String(format: "%.0f", sender.value)
        numberOfPeople = Int(sender.value)
    }
    
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        
        let bill = billTextField.text!
                
                //If the text is not an empty String ""
                if bill != "" {
                    
                   
                    billTotal = Double(bill)!
                    
                    
                    //let result = billTotal * (1 + percentage) / Double(numberOfPeople)
                    
                    let result = (billTotal + (billTotal * percentage)) / Double(numberOfPeople)
                    finalResult = result
                    let resultTo2DecimalPlaces = String(format: "%.2f", result)
                    
                   // print(resultTo2DecimalPlaces)
                    
                  self.performSegue(withIdentifier: "goToResult", sender: self)
                }
       // self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {        self.view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
            if segue.identifier == "goToResult" {
                
                let destinationVC = segue.destination as! ResultsViewController
                destinationVC.result = finalResult
                destinationVC.tip = Int(percentage * 100)
                destinationVC.split = numberOfPeople
            }
        }
}

