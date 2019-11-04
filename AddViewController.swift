//
//  AddViewController.swift
//  Crossfit
//
//  Created by Ana Klabjan on 2/28/19.
//  Copyright © 2019 Ana Klabjan. All rights reserved.
//

import UIKit

protocol AddViewControllerDelegate
{
    func saveWorkout(workout: WOD)
}

class AddViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet var nameTF: UITextField!
    @IBOutlet var lengthTF: UITextField!
    @IBOutlet var explanationTF: UITextView!
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    var delegate: AddViewControllerDelegate!
    
    var workout = WOD(name: "", type: "", length: 0, explanation: "")
    
    @IBAction func typeSC(_ sender: UISegmentedControl) {
        if nameTF.text! != "" && lengthTF.text! != "" && explanationTF.text! != "Workout" && explanationTF.text! != ""
        {
            switch segmentedControl.selectedSegmentIndex
            {
            case 0:
                workout = WOD(name: nameTF.text!, type: "AMRAP", length: Int(lengthTF.text!)!, explanation: explanationTF.text!)
            case 1:
                workout = WOD(name: nameTF.text!, type: "For Time", length: Int(lengthTF.text!)!, explanation: explanationTF.text!)
            case 2:
                workout = WOD(name: nameTF.text!, type: "RFT", length: Int(lengthTF.text!)!, explanation: explanationTF.text!)
            default:
                break
            }
        }
    }
    
    @IBAction func submitPressed(_ sender: UIButton) {
        if workout.name != "" && workout.type != "" && workout.length != 0 && workout.explanation != ""
        {
            delegate.saveWorkout(workout: workout)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if explanationTF.textColor == UIColor.lightGray {
            explanationTF.text = nil
            explanationTF.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if explanationTF.text.isEmpty {
            explanationTF.text = "WOD"
            explanationTF.textColor = UIColor.lightGray
        }
    }
    
    override func viewDidLoad() {
        explanationTF.text = "WOD"
        explanationTF.textColor = UIColor.lightGray
        segmentedControl.selectedSegmentIndex = -1
        explanationTF.delegate = self
        super.viewDidLoad()
    }
}
