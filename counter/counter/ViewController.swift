//
//  ViewController.swift
//  counter
//
//  Created by relex on 14-7-15.
//  Copyright (c) 2014年 relex. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var timelabel:UILabel?
    var playButton:UIButton?
    var clearButton:UIButton?
    
    var countdownSeconds:Int = 0 {
    willSet(newSeconds){
        let min = newSeconds/60
        let seconds = newSeconds%60
        timelabel!.text = NSString(format: "%02d:%02d", min, seconds)
    }
    }
    
    var timer:NSTimer?
    var isCounting:Bool = false {
    willSet(value){
        
        if (value){
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateTimer:", userInfo: nil, repeats: true)
        }else{
            timer?.invalidate();
            timer = nil
        }
    }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        initTimeLabel()
        initActionButton()
        
        countdownSeconds = 0
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        timelabel!.frame = CGRectMake(10, self.view.bounds.size.height/2-60-50, self.view.bounds.size.width-10-10, 120)
        playButton!.frame = CGRectMake(10, self.view.bounds.size.height-60, self.view.bounds.size.width-10 - 100,  50)
        clearButton!.frame = CGRectMake(10 + self.view.bounds.size.width-100, self.view.bounds.size.height-60, 80, 50)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func initTimeLabel(){
        timelabel = UILabel();
        timelabel!.textColor = UIColor.darkGrayColor()
        timelabel!.font = UIFont(name: nil, size: 80)
        timelabel!.textAlignment  = NSTextAlignment.Center
        self.view.addSubview(timelabel)
    }
    
    func initActionButton(){
        
        playButton = UIButton()
        playButton!.backgroundColor = UIColor.brownColor()
        playButton!.setTitle("开始", forState: UIControlState.Normal)
        playButton!.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        playButton!.setTitleColor(UIColor.yellowColor(), forState: UIControlState.Highlighted)
        playButton!.addTarget(self, action: "actionButtonClick:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(playButton)
        
        clearButton = UIButton()
        clearButton!.backgroundColor = UIColor.brownColor()
        clearButton!.setTitle("复位", forState: UIControlState.Normal)
        clearButton!.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        clearButton!.setTitleColor(UIColor.yellowColor(), forState: UIControlState.Highlighted)
        clearButton!.addTarget(self, action: "clearButtonClick:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(clearButton)
    }
    
    func actionButtonClick(sender:UIButton){
        isCounting = !isCounting
        
        if (isCounting){
            playButton!.setTitle("暂停", forState: UIControlState.Normal)
        }else{
            playButton!.setTitle("继续", forState: UIControlState.Normal)
        }
    }
    
    func clearButtonClick(sender:UIButton){
        isCounting = false
        countdownSeconds = 0
        playButton!.setTitle("开始", forState: UIControlState.Normal)
    }
    
    func updateTimer(sender: NSTimer) {
        countdownSeconds += 1
    }
    
}

