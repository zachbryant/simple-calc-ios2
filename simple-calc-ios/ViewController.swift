//
//  ViewController.swift
//  simple-calc-ios
//
//  Created by iGuest on 10/22/17.
//  Copyright © 2017 MacroHard. All rights reserved.
//

import UIKit

protocol Math {
    func add(_ : [String])
    func sub(_ : [String])
    func div(_ : [String])
    func mod(_ : [String])
    func avg(_ : [String])
    func fact(_ : String)
    func mult(_ : [String])
    func count(_ : [String])
}

class ViewController: UIViewController, Math {
    @IBOutlet weak var postFixSwitch: UISwitch!
    @IBOutlet weak var resLabel: UILabel!
    @IBOutlet weak var postFixLabel: UILabel!
    @IBOutlet weak var inputLabel: UILabel!
    var res: String = ""
    var new: Bool = true
    var decimal: Bool = false
    var nums: [String] = []
    var op = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func switchPostFix(_ sender: UISwitch) {
        updateInputLabel()
    }
    
    @IBAction func performAction(_ button: UIButton) {
        let text: String = button.currentTitle!
        switch(text) {
            case "*", "/", "+", "-", "Count", "Avg", "Mod", "Fact":
                new = true
                decimal = false
                op = text
                printResult()
            case "=":
                if nums.count > 0 && nums[nums.count - 1].last == "." {
                    nums.append(nums.removeLast() + "0")
                    decimal = false
                }
                printResult()
            case "Clear":
                clearInput()
                clearResult()
            default:
                if new {
                    if text == "." {
                        nums.append("0" + text)
                    }
                    else {
                        nums.append(text)
                    }
                    new = false
                }
                else {
                    if (text == "." && !decimal) || text != "." {
                        nums.append(nums.removeLast() + text)
                    }
                }
                if text == "." {
                    decimal = true
                }
        }
        updateInputLabel()
    }
    
    func add(_ nums: [String]) {
        var temp: Double = 0.0
        for i in nums {
            temp = temp + Double(i)!
        }
        res = String(temp)
    }
    
    func sub(_ nums: [String]) {
        var temp: Double = Double(nums[0])!
        for i in (1..<nums.count) {
            temp = temp - Double(nums[i])!
        }
        res = String(temp)
    }
    
    func div(_ nums: [String]) {
        var temp: Double = Double(nums[0])!
        for i in (1..<nums.count) {
            temp = temp / Double(nums[i])!
        }
        res = String(temp)
    }
    
    func mod(_ nums: [String]) {
        var temp: Double = Double(nums[0])!
        for i in (1..<nums.count) {
            temp = mod(temp, Double(nums[i])!)
        }
        res = String(temp)
    }
    
    func mod(_ num1: Double, _ num2: Double) -> Double {
        var remainder: Double = num1
        while remainder >= num2 {
            remainder = remainder - num2
        }
        return remainder
    }
    
    func avg(_ nums: [String]) {
        var temp: Double = 0.0
        for n in nums {
            temp = temp + Double(n)!
        }
        res = String(temp / Double(nums.count))
    }
    
    func fact(_ num: String) {
        var fact: Int = 1
        var temp = 0
        if mod(Double(num)!, 1.0) > 0 {
            res = "N/A"
        }
        else {
            temp = Int(num)!
            while temp > 0 {
                fact = fact * temp
                temp = temp - 1
            }
            res = String(fact)
        }
    }
    
    func mult(_ nums: [String]) {
        res = nums[0]
        for i in (1..<nums.count) {
            res = String(Double(res)! * Double(nums[i])!)
        }
    }
    
    func count(_ nums: [String]) {
        res = String(nums.count)
    }
    
    func updateInputLabel() {
        var separator: String = ""
        if postFixSwitch.isOn {
            postFixLabel.text = op
            separator = " "
        }
        else {
            postFixLabel.text = ""
            separator = " " + op + " "
        }
        var temp: String = "..."
        if nums.count > 0 {
            temp = nums[0]
            if nums.count > 1 {
                for i in (1..<nums.count) {
                    temp = temp + separator + nums[i]
                }
            }
            else {
                temp = temp + separator
            }
        }
        inputLabel.text = temp
    }
    
    func printResult() {
        if nums.count > 0 {
            switch op {
                case "+": add(nums)
                case "-": sub(nums)
                case "*": mult(nums)
                case "/": div(nums)
                case "Mod": mod(nums)
                case "Count": count(nums)
                case "Avg": avg(nums)
                case "Fact": fact(nums[0])
                default: res = "0"
            }
        }
        resLabel.text = res
    }
    
    func clearInput() {
        inputLabel.text = ""
        postFixLabel.text = ""
        nums = []
        new = true
        decimal = false
    }
    
    func clearResult() {
        res = "0"
        printResult()
    }
    
}

