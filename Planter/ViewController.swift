//
//  ViewController.swift
//  Planter
//
//  Created by Jiawei Zhou on 4/7/19.
//  Copyright © 2019 Sherry Zhou. All rights reserved.
//

import UIKit

var boardname = "begin"
var goal = 0.0
var showLav: Bool = false
var lavList = [CGRect]()

let dirPath: String = "\(NSHomeDirectory())/tmp"
let filePath: String = "\(NSHomeDirectory())/tmp/lav.txt"

class ViewController: UIViewController {

    private var startingPoint: CGPoint = CGPoint(x: 0, y: 0)
    
    private let seedButton = UIImageView()
    private let fieldButton = UIImageView()
    private let board = UIImageView()
    
    var boardText = UILabel()
    
    let screenSize: CGSize = UIScreen.main.bounds.size
    var centerX = CGFloat()
    var centerY = CGFloat()
    
    let space: CGFloat = 10
    let buttonSize = CGFloat(60)
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        centerX = screenSize.width / 2
        centerY = screenSize.height / 2
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
//        backgroundImage.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        backgroundImage.image = UIImage(named: "main.png")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
//        view.addSubview(backgroundImage)
//        backgroundImage.sendSubviewToBack(view)
        
        fieldButton.frame = CGRect(x: centerX+100, y: screenSize.height-buttonSize-space, width: buttonSize, height: buttonSize)
        fieldButton.image = UIImage(named: "pencil.png")
        fieldButton.isUserInteractionEnabled = true
        fieldButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ViewController.fieldButtonPressed(_:))))
        view.addSubview(fieldButton)
        
        seedButton.frame = CGRect(x: centerX-100-buttonSize, y: screenSize.height-buttonSize-space, width: buttonSize, height: buttonSize)
        seedButton.image = UIImage(named: "shovel.png")
        seedButton.isUserInteractionEnabled = true
        seedButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ViewController.seedButtonPressed(_:))))
        view.addSubview(seedButton)
        
        board.frame = CGRect(x: centerX-50, y: screenSize.height-100-space, width: 100, height: 100)
        board.image = UIImage(named: "board.png")
        view.addSubview(board)
        
        boardText.frame = CGRect(x: centerX-50, y: screenSize.height-100-space, width: 100, height: 50)
        boardText.text = "\(boardname)"
        boardText.textColor = UIColor.black
        boardText.font = UIFont(name: "ChalkboardSE-Bold", size: 15)
        boardText.textAlignment = NSTextAlignment.center
        view.addSubview(boardText)
        boardText.bringSubviewToFront(view)
        
        let swipeLeft: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.handleSwipeLeft(_:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
        
        self.view.addGestureRecognizer(UISwipeGestureRecognizer(target: self, action: #selector(ViewController.handleSwipeRight(_:))))
        
        createDirectory()
        restoreFromFile()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(true)
        
        boardText.text = "\(boardname)"
        view.addSubview(boardText)
        boardText.bringSubviewToFront(view)
        
        displayLav()
    }
    
    func displayLav() {        
        if showLav {
            let ramdomX = CGFloat.random(in: 0...screenSize.width-buttonSize                                                                             )
            let randomY = CGFloat.random(in: centerY...screenSize.height-150)
            
            let newlav = UIImageView()
            newlav.frame = CGRect(x: ramdomX, y:randomY, width: buttonSize, height: buttonSize*2)
            newlav.image = UIImage(named: "lav.png")
//            newlav.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(ViewController.moveLav(_:))))
            view.addSubview(newlav)
            
            lavList.append(CGRect(x: ramdomX, y:randomY, width: buttonSize, height: buttonSize*2))
            print("\n*** Lav List: ", lavList)
            showLav = false
            
            saveToFile()
        }

    }
    
    @objc func handleSwipeLeft(_ recognizer: UISwipeGestureRecognizer) {
        let fc: FieldController = FieldController()
        self.present(fc, animated: false, completion: {() -> Void in
            print("Field controller presented...")
        })
    }
    
    @objc func fieldButtonPressed(_ recognizer: UITapGestureRecognizer) {
        let fc: FieldController = FieldController()
        self.present(fc, animated: false, completion: {() -> Void in
            print("Field controller presented...")
        })
    }
    
    @objc func handleSwipeRight(_ recognizer: UISwipeGestureRecognizer) {
        let sc: SeedController = SeedController()
        self.present(sc, animated: false, completion: {() -> Void in
            print("Seed controller presented...")
        })
    }
    
    @objc func seedButtonPressed(_ recognizer: UITapGestureRecognizer) {
        let sc: SeedController = SeedController()
        self.present(sc, animated: false, completion: {() -> Void in
            print("Seed controller presented...")
        })
    }
    
    @objc func moveLav(_ recognizer: UIPanGestureRecognizer) {
        let view: UIImageView = recognizer.view as! UIImageView
        
        if recognizer.state == UIGestureRecognizer.State.began {
            startingPoint = recognizer.view!.center
            view.superview?.bringSubviewToFront(recognizer.view!)
        }
        
        let translation: CGPoint = recognizer.translation(in: self.view)
        
        if ( view.center.y + translation.y >= centerY ) {
            view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
            recognizer.setTranslation(CGPoint(x: 0, y: 0), in: self.view)
        }
        
        if recognizer.state == UIGestureRecognizer.State.cancelled {
            recognizer.view!.center = startingPoint
        }
    }
    
    private func displayDirectory() {
        print("Absolute path for Home Directory: \(NSHomeDirectory())")
        if let dirEnumerator = FileManager.default.enumerator(atPath: NSHomeDirectory()) {
            while let currentPath = dirEnumerator.nextObject() as? String {
                print(currentPath)
            }
        }
    }

    private func createDirectory() {
        print("Before directory is created...")
        displayDirectory()
        var isDir: ObjCBool = true
        if FileManager.default.fileExists(atPath: dirPath, isDirectory: &isDir) {
            if isDir.boolValue {
                print("\(dirPath) exists and is a directory")
            }
            else {
                print("\(dirPath) exists and is not a directory")
            }
        }
        else {
            print("\(dirPath) does not exist")
            do {
                try FileManager.default.createDirectory(atPath: dirPath, withIntermediateDirectories: true, attributes: nil)
            }
            catch {
                print("Error creating directory \(dirPath): \(error)")
            }
        }
        print("After directory is created...")
        displayDirectory()
    }
    
    private func saveToFile() {
        do {
            print("...saving to file")
            
            let data = try NSKeyedArchiver.archivedData(withRootObject: lavList, requiringSecureCoding: false)
            if FileManager.default.createFile(atPath: filePath,
                                              contents: data,
                                              attributes: nil) {
                print("File \(filePath) successfully created")
            }
            else {
                print("File \(filePath) could not be created")
            }
        }
        catch {
            print("Error archiving data: \(error)")
        }
    }

    private func restoreFromFile() {
        do {
            if let data = FileManager.default.contents(atPath: filePath) {
                print("Retrieving data from file \(filePath)")
                lavList = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [CGRect] ?? [CGRect]()
            }
            else {
                print("No data available in file \(filePath)")
                lavList = [CGRect]()
            }
            
//            lavTableView.reloadData()
            for loc in lavList {
                let restoreLav = UIImageView()
                restoreLav.frame = loc
                restoreLav.image = UIImage(named: "lav.png")
                view.addSubview(restoreLav)
            }
            
        }
        catch {
            print("Error unarchiving data: \(error)")
        }
    }

//    private func deleteFile() {
//        do {
//            try FileManager.default.removeItem(atPath: filePath)
//        }
//        catch {
//            print("Error deleting file: \(error)")
//        }
//    }


}

