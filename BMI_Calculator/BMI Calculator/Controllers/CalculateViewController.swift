//
//  ViewController.swift
//  BMI Calculator
//
//  Created by Yu Mon Aung on 2021/03/23.
//  Copyright © 2021 example.yu.mon.bmi. All rights reserved.
//

import UIKit

class CalculateViewController: UIViewController {

   
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightSlider: UISlider!
    @IBOutlet weak var weightSlider: UISlider!
    
    var bmiValue = "0.0"
    var calculatorBrain = CalculatorBrain()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        heightLabel.text = "1.5m"
        weightLabel.text = "\(weightSlider.value)kg"
    }
  
    
    @IBAction func heighSliderChanged(_ sender: UISlider) {
        heightLabel.text = String(format: "%.1fm", sender.value)
        print( String(format: "%.2f", sender.value));
    }
    @IBAction func weightSliderChanged(_ sender: UISlider) {
        weightLabel.text = String(format: "%.0fkg", sender.value)
        print( String(format: "%.0f", sender.value));
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let weight = weightSlider.value
        let height = heightSlider.value
        
        calculatorBrain.calculateBMI(weight : weight, height : height)
        
        self.performSegue(withIdentifier: "goToResult", sender: self)
        
    }
    
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "goToResult"){
            let destinationVC = segue.destination as! ResultViewController
           
            destinationVC.bmiValue =  calculatorBrain.getBMIValue()
            destinationVC.advice = calculatorBrain.getAdvice()
            destinationVC.color = calculatorBrain.getColor()
        }
    }
 
}

