//
//  ViewController.swift
//  how-fast-press-twice
//
//  Created by Xinhong LIU on 1/4/2017.
//  Copyright © 2017 hall. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    let titles = ["hey", "yoo", "oops", "boom", "yeah", "-"]
    
    var numberOfSpinningWheel = 3
    
    @IBOutlet weak var pickerView1: UIPickerView!
    @IBOutlet weak var pickerView2: UIPickerView!
    @IBOutlet weak var pickerView3: UIPickerView!
    
    var audioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        pickerView1.dataSource = self
        pickerView2.dataSource = self
        pickerView3.dataSource = self
        pickerView1.delegate = self
        pickerView2.delegate = self
        pickerView3.delegate = self
        
        reset(self)
        
        let timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(spinIt), userInfo: nil, repeats: true)
        
//        pickerView1.selectRow(Int(arc4random()) % 6, inComponent: 0, animated: false)
//        pickerView2.selectRow(Int(arc4random()) % 6, inComponent: 0, animated: false)
//        pickerView3.selectRow(Int(arc4random()) % 6, inComponent: 0, animated: false)
        do {
            let soundPath = Bundle.main.path(forResource: "Kids Cheering", ofType: "caf")
            try audioPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: soundPath!))
            audioPlayer.prepareToPlay()
        } catch {
            print("\(error.localizedDescription)")
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10000
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return titles[row % 6]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func stopSpinning(_ sender: Any) {
        if numberOfSpinningWheel > 0 {
            numberOfSpinningWheel = numberOfSpinningWheel - 1
        }
        
        // check if three wheels are at the same position
        if numberOfSpinningWheel == 0 && pickerView1.selectedRow(inComponent: 0) % 6 == pickerView2.selectedRow(inComponent: 0) % 6 && pickerView2.selectedRow(inComponent: 0) % 6 == pickerView3.selectedRow(inComponent: 0) % 6 {
            audioPlayer.play()
        }
    }
    
    @IBAction func reset(_ sender: Any) {
        numberOfSpinningWheel = 3;
        pickerView1.selectRow(Int(arc4random()) % 6 + 10, inComponent: 0, animated: false)
        pickerView2.selectRow(Int(arc4random()) % 6 + 10, inComponent: 0, animated: false)
        pickerView3.selectRow(Int(arc4random()) % 6 + 10, inComponent: 0, animated: false)
    }
    
    func spinIt() {
        if numberOfSpinningWheel == 3 {
            pickerView1.selectRow(pickerView1.selectedRow(inComponent: 0) + 1, inComponent: 0, animated: true)
        }
        if numberOfSpinningWheel >= 2 {
            pickerView2.selectRow(pickerView2.selectedRow(inComponent: 0) + 1, inComponent: 0, animated: true)
        }
        if numberOfSpinningWheel >= 1 {
            pickerView3.selectRow(pickerView3.selectedRow(inComponent: 0) + 1, inComponent: 0, animated: true)
        }
    }
}

