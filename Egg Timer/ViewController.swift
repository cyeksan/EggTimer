//
//  ViewController.swift
//  Egg Timer
//
//  Created by Cansu Aktas on 2023-08-08.
//

import UIKit

class ViewController: UIViewController {
    var timePassed = 0
    var totalTime = 0
    var percentageProgress: Float = 0.0
    var timer = Timer()
    
    let softTime: Int
    let mediumTime: Int
    let hardTime: Int
    
    let soft = "Soft"
    let medium = "Medium"
    let hard = "Hard"
    
    let eggTimes: [String: Int]

    @IBOutlet weak var softImage: UIImageView!
    @IBOutlet weak var mediumImage: UIImageView!
    @IBOutlet weak var hardImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    required init(coder decoder: NSCoder) {
        let minToSec = 60
        self.softTime = 5 * minToSec
        self.mediumTime = 7 * minToSec
        self.hardTime = 12 * minToSec
        self.eggTimes = [soft: softTime, medium: mediumTime, hard: hardTime]
        super.init(coder: decoder)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        progressView.progress = 0
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        if let hardness = sender.titleLabel?.text {
            setSelected(hardness: hardness)
            resetToNewHardness(hardness: hardness)
            startTimer()
        }
    }
    
    func setSelected(hardness: String) {
        softImage.backgroundColor = hardness == soft ? UIColor.darkGray : UIColor(named: "AppBackground")
        mediumImage.backgroundColor = hardness == medium ? UIColor.darkGray : UIColor(named: "AppBackground")
        hardImage.backgroundColor = hardness == hard ? UIColor.darkGray : UIColor(named: "AppBackground")
    }
    
    func resetToNewHardness(hardness: String) {
        progressView.progress = 0
        titleLabel.text = "Cooking..."
        totalTime = setCounter(hardness: hardness)
        timePassed = totalTime
        percentageProgress = 1 / Float(totalTime)
    }
    
    func setCounter(hardness: String) -> Int {
        return eggTimes[hardness]!
    }
    
    func startTimer() {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounter() {
        if timePassed > 0 {
            print("\(timePassed) seconds to cook")
            progressView.progress = progressView.progress + percentageProgress
            timePassed -= 1
        } else {
            timer.invalidate()
            titleLabel.text = "Done ✅"
        }
    }
}

