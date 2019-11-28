//
//  FieldController.swift
//  Planter
//
//  Created by Jiawei Zhou on 4/7/19.
//  Copyright © 2019 Sherry Zhou. All rights reserved.
//

import UIKit

class FieldController: UIViewController, UITextFieldDelegate {
    
    private let home = UIImageView()
    
    private let nameLabel = UILabel()
    var name = ""
    private var nameTextField = UITextField()
    
    private let goalLabel = UILabel()
    var times = 0.0
    private var goalTextField = UITextField()
    
    private let confirmButton = UIButton()
    private let cancelButton = UIButton()
    
    private let screenSize: CGSize = UIScreen.main.bounds.size
    private var centerX = CGFloat()
    private var centerY = CGFloat()
    
    private let homeSize: CGFloat = 50
    private let space: CGFloat = 10
    private var fillout = CGFloat()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        centerX = screenSize.width / 2
        centerY = screenSize.height / 2
        fillout = screenSize.height / 4
        let buttonSize = CGFloat(60)
        
        home.frame = CGRect(x: centerX - homeSize/2, y: space*4, width: homeSize, height: homeSize)
        home.image = UIImage(named: "home.png")
        home.isUserInteractionEnabled = true
        home.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(FieldController.homePressed(_:))))
        view.addSubview(home)
        
        nameLabel.frame = CGRect(x: space, y: fillout, width: screenSize.width, height: fillout/4)
        nameLabel.font = UIFont(name: "Chalkduster", size: fillout/5)
        nameLabel.text = "Field"
        nameLabel.textAlignment = NSTextAlignment.left
        view.addSubview(nameLabel)
        
        nameTextField.frame = CGRect(x: space, y: fillout*3/2, width: screenSize.width-space*2, height: fillout/4)
        nameTextField.borderStyle = .roundedRect
        nameTextField.clearButtonMode = .whileEditing
        nameTextField.placeholder = "What is the goal you want to achieve?"
        view.addSubview(nameTextField)
        
        goalLabel.frame = CGRect(x: space, y: fillout*2, width: screenSize.width, height: fillout/4)
        goalLabel.font = UIFont(name: "Chalkduster", size: fillout/5)
        goalLabel.text = "Goal"
        goalLabel.textAlignment = NSTextAlignment.left
        view.addSubview(goalLabel)
        
        goalTextField.frame = CGRect(x: space, y: fillout*5/2, width: screenSize.width-space*2, height: fillout/4)
        goalTextField.borderStyle = .roundedRect
        goalTextField.clearButtonMode = .whileEditing
        goalTextField.placeholder = "How many hours you want to achieve?"
        view.addSubview(goalTextField)
        
        confirmButton.frame = CGRect(x: centerX-buttonSize*2, y: screenSize.height-fillout, width: buttonSize, height: buttonSize)
        confirmButton.setImage(UIImage(named: "confirm"), for: UIControl.State.normal)
        view.addSubview(confirmButton)
        confirmButton.isEnabled = true
        confirmButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(FieldController.confirmButtonPressed(_:))))
        
        cancelButton.frame = CGRect(x: centerX+buttonSize, y: screenSize.height-fillout, width: buttonSize, height: buttonSize)
        cancelButton.setImage(UIImage(named: "cancel"), for: UIControl.State.normal)
        view.addSubview(cancelButton)
        cancelButton.isEnabled = true
        cancelButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(FieldController.cancelButtonPressed(_:))))
        
    }
    
    
    @objc func homePressed(_ recognizer: UITapGestureRecognizer) {
        self.presentingViewController?.dismiss(animated: true, completion: {() -> Void in
            print("Field controller dismissed...")})
    }
    
    @objc func confirmButtonPressed(_ recognizer: UITapGestureRecognizer) {
//        let vc = ViewController()
//        name = nameTextField.text!
        
        if boardname == "" {
            boardname = self.nameTextField.text!
            goal = Double(self.goalTextField.text ?? "0.0") ?? 0.0
//
//            vc.boardText.frame = CGRect(x: self.centerX-50, y: vc.screenSize.height-100-vc.space, width: 50, height: 50)
//            vc.boardText.text = vc.boardname
//            vc.boardText.textColor = UIColor.black
//            vc.boardText.font = UIFont(name: "ChalkboardSE-Bold", size: 15)
//            vc.boardText.textAlignment = NSTextAlignment.center
//            print("\nTEST: ",vc.boardname, vc.goal, vc.boardText)

//            vc.view.addSubview(vc.boardText)
//            vc.boardText.bringSubviewToFront(vc.view)
            
//            vc.boardText.text = "\(self.name)"
            self.presentingViewController?.dismiss(animated: true, completion: {() -> Void in
                print("Field controller dismissed...")})
        }
        else {
            let alert: UIAlertController = UIAlertController(title: "Override", message: "Do you want to override your current field and goal?", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "Yes", style:UIAlertAction.Style.default, handler: {(action: UIAlertAction!) -> Void in
                //update info
                boardname = self.nameTextField.text!
                goal = Double(self.goalTextField.text ?? "0.0") ?? 0.0
                print("\nTEST: ", boardname, goal)
                
                self.deleteFile()
//                vc.goal = Double(self.goalTextField.text ?? "0.0") ?? 0.0
//
//                //update board on main screen
//                vc.boardText.frame = CGRect(x: self.centerX-50, y: vc.screenSize.height-100-vc.space, width: 50, height: 50)
//                vc.boardText.text = vc.boardname
//                vc.boardText.textAlignment = NSTextAlignment.center
//                print("\nTEST: ",vc.boardname, vc.goal, vc.boardText)
//
//                vc.view.addSubview(vc.boardText)
//                vc.boardText.bringSubviewToFront(vc.view)
                
//                vc.boardText.text = "\(self.name)"
                
                
//                self.presentingViewController?.dismiss(animated: true, completion: {() -> Void in
//                    print("Field controller dismissed...")})
                
                let vc: ViewController = ViewController()
                self.present(vc, animated: false, completion: {() -> Void in
                    print("View controller presented...")
                })
            }))
            
            alert.addAction(UIAlertAction(title: "No", style:UIAlertAction.Style.default, handler: {(action: UIAlertAction!) -> Void in
                
                self.presentingViewController?.dismiss(animated: true, completion: {() -> Void in
                    print("Field controller dismissed...")})
            }))
            
            self.present(alert, animated: true, completion:
                {() -> Void in
                    
            })
        }
    }
    
    @objc func cancelButtonPressed(_ recognizer: UITapGestureRecognizer) {
        nameTextField.text = ""
        goalTextField.text = ""
    }
    
    private func deleteFile() {
        do {
            print("...deleting file")
            try FileManager.default.removeItem(atPath: filePath)
        }
        catch {
            print("Error deleting file: \(error)")
        }
    }

}
