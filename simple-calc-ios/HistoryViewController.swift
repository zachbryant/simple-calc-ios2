//
//  HistoryViewController.swift
//  simple-calc-ios
//
//  Created by iGuest on 10/30/17.
//  Copyright © 2017 MacroHard. All rights reserved.
//

import Foundation
import UIKit

class HistoryViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    //@IBOutlet weak var stackView: UIStackView!
    weak var oldField: UILabel!
    var entries: [String] = []
    var res: String = ""
    var new: Bool = true
    var done: Bool = false
    var decimal: Bool = false
    var nums: [String] = []
    var op = ""
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "mainSegue":
            let mainVC = segue.destination as! ViewController
            mainVC.history = entries
            mainVC.new = new
            mainVC.done = done
            mainVC.decimal = decimal
            mainVC.res = res
            mainVC.op = op
            mainVC.nums = nums
        default:
            NSLog("%s is an unknown segue", segue.identifier!)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        for e in entries {
            let en = e.replacingOccurrences(of: "\n=", with: " = ")
            NSLog(en)
            let field = UILabel()
            field.numberOfLines = 2
            field.text = en
            scrollView.addSubview(field)
            field.translatesAutoresizingMaskIntoConstraints = false
            field.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
            field.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
            field.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
            field.heightAnchor.constraint(equalToConstant: CGFloat(truncating: NSNumber(value: 40.0))).isActive = true
            if oldField != nil {
                field.topAnchor.constraint(equalTo: oldField.bottomAnchor).isActive = true
            }
            else {
                field.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
            }
            oldField = field
        }
        scrollView.showsVerticalScrollIndicator = true
    }
}
