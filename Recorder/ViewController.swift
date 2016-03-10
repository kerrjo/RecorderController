//
//  ViewController.swift
//  Recorder
//
//  Created by JOSEPH KERR on 3/4/16.
//  Copyright © 2016 JOSEPH KERR. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: Properties
    
    @IBOutlet weak var recordButton: UIButton!
    
    var audioRecorder: JWAudioRecorderController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioRecorder = JWAudioRecorderController(metering: false)

//        audioRecorder = JWAudioRecorderController()
//        audioRecorder!.initializeController()
        
        print ("\(audioRecorder?.recordingId)")
        
        recordButton.setTitle("Record", forState: .Normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: button actions
    
    @IBAction func recordButtonPressed(sender: UIButton) {
        
        if let ar = audioRecorder {
            if ar.recording {
                ar.stopRecording()
                recordButton.setTitle("Record", forState: .Normal)


            } else {
                ar.record()
                recordButton.setTitle("Stop Recording", forState: .Normal)
            }
        }
    }
}

