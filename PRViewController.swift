//
//  PRViewController.swift
//  Crossfit
//
//  Created by Ana Klabjan on 4/26/19.
//  Copyright © 2019 Ana Klabjan. All rights reserved.
//

import UIKit

class PRViewController: UIViewController {
    
    var exersize = lift(name: "", best: 0)
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var newPR: UITextField!
    @IBOutlet var onehundredandfive: UILabel!
    @IBOutlet var onehundred: UILabel!
    @IBOutlet var nintyfive: UILabel!
    @IBOutlet var ninty: UILabel!
    @IBOutlet var eightyfive: UILabel!
    @IBOutlet var eighty: UILabel!
    @IBOutlet var seventyfive: UILabel!
    @IBOutlet var seventy: UILabel!
    @IBOutlet var sixtyfive: UILabel!
    @IBOutlet var sixty: UILabel!
    
    @IBAction func SubmitPressed(_ sender: UIButton) {
        if newPR.text != ""
        {
            exersize.best = Int(newPR.text!)!
            updateLabels()
        }
    }
    
    
    func updateLabels()
    {
        onehundredandfive.text = "105%    \(Double(exersize.best)*1.05)"
        onehundred.text = "100%    \(Double(exersize.best))"
        nintyfive.text = "95%    \(Double(exersize.best)*0.95)"
        ninty.text = "90%    \(Double(exersize.best)*0.9)"
        eightyfive.text = "85%    \(Double(exersize.best)*0.85)"
        eighty.text = "80%    \(Double(exersize.best)*0.8)"
        seventyfive.text = "75%    \(Double(exersize.best)*0.75)"
        seventy.text = "70%    \(Double(exersize.best)*0.7)"
        sixtyfive.text = "65%    \(Double(exersize.best)*0.65)"
        sixty.text = "60%    \(Double(exersize.best)*0.6)"    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = exersize.name
        updateLabels()
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
