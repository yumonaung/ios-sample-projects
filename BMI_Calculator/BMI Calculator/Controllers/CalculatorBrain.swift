//
//  CalculatorBrain.swift
//  BMI Calculator
//
//  Created by Yu Mon Aung on 2021/03/23.
//  Copyright © 2021 example.yu.mon.bmi. All rights reserved.
//

import Foundation
import UIKit
struct CalculatorBrain {

    var bmi: BMI?
    
    mutating func calculateBMI(weight:Float,height:Float) {
       let bmiValue = weight/(pow(height, 2))
       
        if bmiValue < 18.5 {
            bmi = BMI(value: bmiValue, advice: "Eat more pies", color: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1))
            print("underweight")
        }else if bmiValue < 24.9 {
            bmi = BMI(value: bmiValue, advice: "All ok", color: #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1))
            print("normal weight")
        }else{
            bmi = BMI(value: bmiValue, advice: "Eat less pies", color: #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))
            print("overweight")
        }
    }
    
    func getAdvice() -> String {
        return bmi?.advice ?? ""
        
    }
    
    func getColor() -> UIColor {
        
        return bmi?.color ?? #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
    }
    func getBMIValue() -> String{
        let bmiTo1DecimalPlace = String(format: "%.1f", bmi?.value ?? 0 )
        return bmiTo1DecimalPlace
    }
}
