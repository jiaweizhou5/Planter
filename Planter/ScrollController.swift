//
//  ScrollController.swift
//  Planter
//
//  Created by Jiawei Zhou on 5/5/19.
//  Copyright © 2019 Sherry Zhou. All rights reserved.
//

import UIKit

class ScrollController: UIViewController, UIScrollViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let picture: UIImageView = UIImageView(image: UIImage(named: "master.jpg"))
        picture.tag = 100
        let scrollView: UIScrollView = UIScrollView(frame: view.frame)
        scrollView.delegate = self
        scrollView.minimumZoomScale = 0.25
        scrollView.maximumZoomScale = 2.0
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentSize = picture.frame.size
        scrollView.contentOffset = CGPoint(x: (picture.frame.width-view.frame.width)/2,y: (picture.frame.height-view.frame.height)/2)
        scrollView.addSubview(picture)
        view = scrollView
        // Tap to dismiss to return to the control view controller
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ScrollController.dismissViewController(_:))))
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return view.viewWithTag(100)
    }
    
    // Return to previous view controller when user swipes right
    @objc func dismissViewController(_ recognizer: UITapGestureRecognizer) {
        presentingViewController?.dismiss(animated: true, completion: {() -> Void in
        })
    }
}
