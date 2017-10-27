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
    @IBOutlet weak var resLabel: UILabel!
    var res: String = ""
    var new: Bool = true
    var done: Bool = false
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
    
    @IBAction func clickEquals(_ button: UIButton) {
        if nums.count > 0 && nums[nums.count - 1].last == "." {
            nums.append(nums.removeLast() + "0")
            decimal = false
        }
        updateLabel()
        done = true
    }
    
    @IBAction func clickClear(_ button: UIButton) {
        clear()
    }
    
    @IBAction func clickNum(_ button: UIButton) {
        if done {
            clear()
        }
        let text: String = button.currentTitle!
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
        updateLabel()
    }
    
    @IBAction func clickOperator(_ button: UIButton) {
        let text: String = button.currentTitle!
        done = text == "Fact"
        new = true
        decimal = false
        op = text
        updateLabel()
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
        if num.index(of: ".") != nil {
            res = "N/A"
        }
        else {
            temp = Int(num)!
            NSLog(String(temp))
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
    
    func updateLabel() {
        var separator: String = ""
        separator = " " + op + " "
        var temp: String = separator
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
        resLabel.text = temp + "\n=" + res
    }
    
    func clear() {
        nums = []
        new = true
        decimal = false
        done = false
        op = ""
        res = "0"
        updateLabel()
    }
    
}

