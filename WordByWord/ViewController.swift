//
//  ViewController.swift
//  WordByWord
//
//  Created by 刘剑文 on 15/12/7.
//  Copyright © 2015年 kevinil. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var kevinText : UILabel!
    var masks = [UIView]()
    var showTimer = NSTimer()
    var textIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupText()
        createMaskViews()
        showTimer = NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector: "showText", userInfo: nil, repeats: false)
    }
    
    func setupText() {
        kevinText = UILabel(frame: CGRectMake(50,100,300,500))
        kevinText.numberOfLines = 0
        kevinText.text = "轻雨轻步，仰止一粟嘲身处。\n浊酒浊情，饮胜孤吟浪剑行。\n\nKeviNil"
        kevinText.font = UIFont(name: "Courier", size: 20)
        kevinText.sizeToFit()
        kevinText.textColor = .whiteColor()
        view.addSubview(kevinText)
    }
    
    func createMaskViews() {
        print("kevin frame \(kevinText.frame)")
        for index in 0..<26 {
            let maskView = UIView(frame: CGRectMake(50 + CGFloat(index % 13) * 20, 98 + CGFloat(index / 13) * 20, 23, 23))
            maskView.backgroundColor = .blackColor()
            masks.append(maskView)
            view.addSubview(maskView)
        }
    }
    
    func showText() {
        masks.shuffleInPlace()
        for index in 0..<masks.count {
            blinkShow(masks[index], index: index)
        }
    }
    
    func blinkShow(theView: UIView, index: Int) {
        //every word shows quickly one by one.   (delay 0.02)
        UIView.animateWithDuration(0.1, delay: NSTimeInterval(index) * 0.02, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            theView.alpha = 0.3
            }, completion: { (finish) -> Void in
                UIView.animateWithDuration(0.1, animations: { () -> Void in
                    theView.alpha = 0.7
                    }, completion: { (finish) -> Void in
                        UIView.animateWithDuration(0.1, animations: { () -> Void in
                            theView.alpha = 0
                            }, completion: { (finish) -> Void in
                                UIView.animateWithDuration(0.1, animations: { () -> Void in
                                    theView.alpha = 0.3
                                    }, completion: { (finish) -> Void in
                                        UIView.animateWithDuration(0.1, animations: { () -> Void in
                                            theView.alpha = 0.7
                                            }, completion: { (finish) -> Void in
                                                UIView.animateWithDuration(0.1, animations: { () -> Void in
                                                    theView.alpha = 0
                                                    }, completion: { (finish) -> Void in
                                                        theView.removeFromSuperview()
                                                        //well, maybe more animation
                                                })
                                        })
                                })
                        })
                })
        })
    }
}


//from stackoverflow

extension CollectionType {
    /// Return a copy of `self` with its elements shuffled
    func shuffle() -> [Generator.Element] {
        var list = Array(self)
        list.shuffleInPlace()
        return list
    }
}

extension MutableCollectionType where Index == Int {
    /// Shuffle the elements of `self` in-place.
    mutating func shuffleInPlace() {
        // empty and single-element collections don't shuffle
        if count < 2 { return }
        
        for i in 0..<count - 1 {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            guard i != j else { continue }
            swap(&self[i], &self[j])
        }
    }
}

