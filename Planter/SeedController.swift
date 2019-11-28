//
//  SeedController.swift
//  Planter
//
//  Created by Jiawei Zhou on 4/10/19.
//  Copyright © 2019 Sherry Zhou. All rights reserved.
//

import UIKit

let lavTableView: UITableView = UITableView()

class SeedController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let home = UIImageView()
//    private let timer = UIDatePicker()
    private let timerLabel = UILabel()
    private let startButton = UIButton()
    private let pauseButton = UIButton()
    private let resetButton = UIButton()
    private let endButton = UIButton()
    private let lav = UIImageView()
    
    private var isTimeRunning = false
    
    private let screenSize: CGSize = UIScreen.main.bounds.size
    private var centerX = CGFloat()
    private var centerY = CGFloat()
    
    private let homeSize: CGFloat = 50
    private let space: CGFloat = 10
    
    var timer = Timer()
    var isTimerRunning: Bool = false
    var counter = 0.0
    let buttonSize = CGFloat(60)
  
    let LAVCELL: String = "LavCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        centerX = screenSize.width / 2
        centerY = screenSize.height / 2
        
        home.frame = CGRect(x: centerX - homeSize/2, y: space*4, width: homeSize, height: homeSize)
        home.image = UIImage(named: "home.png")
        home.isUserInteractionEnabled = true
        home.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(SeedController.homePressed(_:))))
        view.addSubview(home)
        
//        timer.frame = CGRect(x: 10, y: centerY/3, width: self.view.frame.width-20, height: 200)
//        timer.backgroundColor = UIColor(white: 1, alpha: 0.5)
//        timer.datePickerMode = UIDatePicker.Mode.countDownTimer
//        timer.addTarget(self, action: #selector(SeedController.datePickerValueChanged(_:)), for: .valueChanged)
//        view.addSubview(timer)
        
        let size = screenSize.width/3
        
        startButton.frame = CGRect(x: 0, y: centerY/3 + 210, width: size, height: 50)
        startButton.setTitle("Start", for: .normal)
        startButton.setTitleColor(UIColor(hue: 0.3222, saturation: 1, brightness: 0.42, alpha: 1.0), for: .normal)
        view.addSubview(startButton)
        startButton.isEnabled = true
        startButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(SeedController.startButtonPressed(_:))))
        
        pauseButton.frame = CGRect(x: size, y: centerY/3 + 210, width: size, height: 50)
        pauseButton.setTitle("Pause", for: .normal)
        pauseButton.setTitleColor(UIColor(hue: 0.3222, saturation: 1, brightness: 0.42, alpha: 1.0), for: .normal)
        view.addSubview(pauseButton)
        pauseButton.isEnabled = false
        pauseButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(SeedController.pauseButtonPressed(_:))))
        
        resetButton.frame = CGRect(x: size*2, y: centerY/3 + 210, width: size, height: 50)
        resetButton.setTitle("Reset", for: .normal)
        resetButton.setTitleColor(UIColor(hue: 0.3222, saturation: 1, brightness: 0.42, alpha: 1.0), for: .normal)
        view.addSubview(resetButton)
        resetButton.isEnabled = false
        resetButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(SeedController.resetButtonPressed(_:))))
        
        endButton.frame = CGRect(x: 10, y: centerY+50, width: self.view.frame.width-20, height: 50)
        endButton.setTitle("End", for: .normal)
        endButton.setTitleColor(UIColor(hue: 0.3222, saturation: 1, brightness: 0.42, alpha: 1.0), for: .normal)
        view.addSubview(endButton)
        endButton.isEnabled = false
        endButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(SeedController.endButtonPressed(_:))))
        
        timerLabel.frame = CGRect(x: 10, y: centerY/3, width: self.view.frame.width-20, height: 200)
        timerLabel.backgroundColor = UIColor(white: 1, alpha: 0.5)
        timerLabel.font = UIFont(name: "ChalkboardSE-Bold", size: 60)
        timerLabel.textAlignment = NSTextAlignment.center
//        timerLabel.text = "\(hour) : \(minute) : \(second)"
        view.addSubview(timerLabel)
        
        lav.frame = CGRect(x: screenSize.width, y: screenSize.height, width: buttonSize, height: buttonSize*2)
        lav.image = UIImage(named: "lav.png")
        view.addSubview(lav)
        
        lavTableView.frame = CGRect(x: screenSize.width, y: screenSize.height, width: 300, height: 350)
        lavTableView.dataSource = self
        lavTableView.delegate = self
        view.addSubview(lavTableView)
        
    }
    
    @objc func homePressed(_ recognizer: UITapGestureRecognizer) {
        self.presentingViewController?.dismiss(animated: true, completion: {() -> Void in
            print("Field controller dismissed...")})
    }
    
    @objc func startButtonPressed(_ recognizer: UITapGestureRecognizer) {
        if !isTimeRunning {
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(runTimer), userInfo: nil, repeats: true)
            isTimeRunning = true
            pauseButton.isEnabled = true
            resetButton.isEnabled = true
            startButton.isEnabled = false
            endButton.isEnabled = true
        }
    }
    
    @objc func runTimer() {
        counter += 0.1
        
        let flooredCounter = Int(floor(counter))
        let hour = flooredCounter/3600
        
        let minute = (flooredCounter % 3600) / 60
        var minuteString = "\(minute)"
        if minute < 10 {
            minuteString = "0\(minute)"
        }
        
        let second = (flooredCounter % 3600) % 60
        var secondString = "\(second)"
        if second < 10 {
            secondString = "0\(second)"
        }
        
//        let decisecond = String(format: "%.1f", counter).components(separatedBy: ".").last!
        
        timerLabel.text = "\(hour) : \(minuteString) : \(secondString)"
    }
    
    @objc func pauseButtonPressed(_ recognizer: UITapGestureRecognizer) {
        startButton.isEnabled = true
        pauseButton.isEnabled = false
        resetButton.isEnabled = true
        endButton.isEnabled = true
        
        isTimeRunning = false
        timer.invalidate()
        
    }
    
    @objc func resetButtonPressed(_ recognizer: UITapGestureRecognizer) {
        timer.invalidate()
        isTimeRunning = false
        counter = 0.0
        
        timerLabel.text = "0 : 00 : 00"
        resetButton.isEnabled = false
        pauseButton.isEnabled = false
        endButton.isEnabled = false
        startButton.isEnabled = true
    }
    
    @objc func endButtonPressed(_ recognizer: UITapGestureRecognizer) {
        timer.invalidate()
        isTimeRunning = false
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 1.5, delay: 0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            () -> Void in
            self.lav.frame = CGRect(x: self.centerX-self.buttonSize/2, y: self.screenSize.height-self.buttonSize*3, width: self.buttonSize, height: self.buttonSize*2)
            
        }, completion: {
            (Bool) -> Void in
            
            let alert: UIAlertController = UIAlertController(title: "End Session", message: "Do you want to end your current seed growing session?", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "Yes", style:UIAlertAction.Style.default, handler: {(action: UIAlertAction!) -> Void in
                
                let flooredCounter = Int(floor(self.counter))
                let hour = Double(flooredCounter/3600)
                
                goal = goal - hour
                print("goal: ", goal, ", hour: ", hour)
                
                if goal <= 0 {
                    let alert: UIAlertController = UIAlertController(title: "Goal Achieved", message: "Congratulations! You have achieved your goal!", preferredStyle: UIAlertController.Style.alert)
                    
                    alert.addAction(UIAlertAction(title: "OK", style:UIAlertAction.Style.default, handler: {(action: UIAlertAction!) -> Void in
                        
                        self.presentingViewController?.dismiss(animated: true, completion: {() -> Void in
                            print("Seed controller dismissed...")})
                    }))
                    
                }
                
                showLav = true
                print(showLav)
                
                self.presentingViewController?.dismiss(animated: true, completion: {() -> Void in
                    print("Seed controller dismissed...")})
            }))
            
            alert.addAction(UIAlertAction(title: "No", style:UIAlertAction.Style.default, handler: {(action: UIAlertAction!) -> Void in
                
            }))
            
            self.present(alert, animated: true, completion:
                {() -> Void in
                    
            })
            
        })
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lavList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LAVCELL) ?? UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: LAVCELL)
        let loc: CGRect
        loc = lavList[indexPath.row]
        cell.textLabel?.text = String("\(loc)")
        return cell
    }
    
    
//    @objc func datePickerValueChanged(_ sender: UIDatePicker){
//        print("Selected value \(sender.countDownDuration)")
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }

    

    
}
