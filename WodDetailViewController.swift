//
//  ViewController.swift
//  Crossfit
//
//  Created by Ana Klabjan on 2/26/19.
//  Copyright © 2019 Ana Klabjan. All rights reserved.
//

import UIKit
import MessageUI
import MobileCoreServices

class WodDetailViewController: UIViewController, MFMailComposeViewControllerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate  {

    var workout:WOD!
    var controller = UIImagePickerController()
    let videoFileName = "/video.mp4"
    
    @objc func buttonAction(sender: UIButton!) {
        if !MFMailComposeViewController.canSendMail() {
            print("Can not send mail")
            return
        }
        else
        {
            let mailComposer = MFMailComposeViewController()
            mailComposer.mailComposeDelegate = self
            mailComposer.setToRecipients([""])
            mailComposer.setSubject(workout.name)
            mailComposer.setMessageBody("\(workout.type)\n \(workout.length) minutes \n \(workout.explanation)", isHTML: false)
            present(mailComposer, animated: true, completion: nil)
        }
    }
    
    @objc func videoAction(sender: UIButton!)
    {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                
                controller.sourceType = .camera
                controller.mediaTypes = [kUTTypeMovie as String]
                controller.delegate = self
                
                present(controller, animated: true, completion: nil)
            }
            else {
                print("Camera is not available")
            }
        }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // 1
        if let selectedVideo:URL = (info[UIImagePickerController.InfoKey.mediaURL] as? URL) {
            // Save video to the main photo album
            let selectorToCall = #selector(WodDetailViewController.videoSaved(_:didFinishSavingWithError:context:))
            
            // 2
            UISaveVideoAtPathToSavedPhotosAlbum(selectedVideo.relativePath, self, selectorToCall, nil)
            // Save the video to the app directory
            let videoData = try? Data(contentsOf: selectedVideo)
            let paths = NSSearchPathForDirectoriesInDomains(
                FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
            let documentsDirectory: URL = URL(fileURLWithPath: paths[0])
            let dataPath = documentsDirectory.appendingPathComponent(videoFileName)
            try! videoData?.write(to: dataPath, options: [])
        }
        // 3
        picker.dismiss(animated: true)
    }
    
    @objc func videoSaved(_ video: String, didFinishSavingWithError error: NSError!, context: UnsafeMutableRawPointer){
        if let theError = error {
            print("error saving the video = \(theError)")
        } else {
            DispatchQueue.main.async(execute: { () -> Void in
            })
        }
    }
 
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let labels = [UILabel(),UILabel(),UILabel(),UILabel()]
        let shareButton = UIButton()
        let videoButton = UIButton()
        
        labels[0].text = workout.name
        if workout.type == "AMRAP"
        {
        labels[1].text = "\(workout.length) minutes"
        }
        else
        {
        labels[1].text = "\(workout.length) minute cap"
        }
        labels[2].text = workout.type
        labels[3].text = workout.explanation
        
        for label in labels
        {
            label.textColor = .white
            label.textAlignment = .center
            label.font = label.font.withSize(25)
            label.numberOfLines = 0
            self.view.addSubview(label)
        }
        
        self.view.addSubview(shareButton)
        shareButton.backgroundColor = .orange
        shareButton.setTitle("Email WOD", for: .normal)
        shareButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        self.view.addSubview(videoButton)
        videoButton.backgroundColor = .orange
        videoButton.setTitle("Record WOD", for: .normal)
        videoButton.addTarget(self, action: #selector(videoAction), for: .touchUpInside)
        
        labels[0].translatesAutoresizingMaskIntoConstraints = false
        labels[1].translatesAutoresizingMaskIntoConstraints = false
        labels[2].translatesAutoresizingMaskIntoConstraints = false
        labels[3].translatesAutoresizingMaskIntoConstraints = false
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        videoButton.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            labels[0].topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 30.0),
            labels[0].leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25.0),
            labels[0].rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25.0),
            labels[0].bottomAnchor.constraint(equalTo: labels[1].topAnchor, constant: -30),
            labels[1].leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25.0),
            labels[1].rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25.0),
            labels[1].bottomAnchor.constraint(equalTo: labels[2].topAnchor, constant: -30),
            labels[2].leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25.0),
            labels[2].rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25.0),
            labels[2].bottomAnchor.constraint(equalTo: labels[3].topAnchor, constant: -30),
            labels[3].leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25.0),
            labels[3].rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25.0),
            labels[3].bottomAnchor.constraint(equalTo: shareButton.topAnchor, constant: -30),
            shareButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -125),
            shareButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 125),
            shareButton.bottomAnchor.constraint(equalTo: videoButton.topAnchor, constant: -30),
            videoButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -125),
            videoButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 125),
            ])
    }
}

