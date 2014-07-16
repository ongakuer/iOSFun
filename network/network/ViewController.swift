//
//  ViewController.swift
//  network
//
//  Created by relex on 14-7-15.
//  Copyright (c) 2014年 relex. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let buttonView:UIButton = UIButton()
    let textView:UITextView = UITextView()
    let progressView:UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
    let afHttpManager = AFHTTPRequestOperationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonView.setTranslatesAutoresizingMaskIntoConstraints(false)
        buttonView.setTitle("Get", forState: UIControlState.Normal)
        
        buttonView.setTitleColor(UIColor.purpleColor(), forState: UIControlState.Normal)
        buttonView.layer.borderColor = UIColor.purpleColor().CGColor
        buttonView.layer.borderWidth = 1
        buttonView.layer.cornerRadius = 6
        buttonView.addTarget(self, action: "fetchUrl:", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(buttonView)
        
        let buttonViewWidth = NSLayoutConstraint(item: buttonView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 100.0)
        let buttonViewHeight = NSLayoutConstraint(item: buttonView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 40.0)
        
        let buttonViewX = NSLayoutConstraint(item: buttonView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        let buttonViewY = NSLayoutConstraint(item: buttonView, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterY, multiplier: 0.4, constant:-10)
        
        view.addConstraints([ buttonViewWidth, buttonViewHeight,buttonViewX, buttonViewY ])
        
        progressView.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(progressView)
        let progressViewX = NSLayoutConstraint(item: progressView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: buttonView, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        let progressViewY = NSLayoutConstraint(item: progressView, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: buttonView, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant:  0)
        view.addConstraints([ progressViewX, progressViewY ])
        
        
        textView.setTranslatesAutoresizingMaskIntoConstraints(false)
        textView.backgroundColor = UIColor.lightGrayColor()
        textView.editable = false
        view.addSubview(textView)
        
        let textViewTop = NSLayoutConstraint(item: textView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterY, multiplier: 0.7, constant: -10)
        let textViewBottom = NSLayoutConstraint(item: textView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: -10)
        let textViewLeft = NSLayoutConstraint(item: textView, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 10)
        let textViewRight = NSLayoutConstraint(item: textView, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: -10)
        
        view.addConstraints([ textViewTop, textViewBottom,textViewLeft ,textViewRight])
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        if self.view.window == nil {
            self.view = nil
        }
        
    }
    
    func fetchUrl(Send:UIButton){
        if (!progressView.isAnimating()){
            
            progressView.startAnimating()
            buttonView.setTitle("", forState: UIControlState.Normal)
            textView.text = ""
            
            afHttpManager.GET("http://api.openweathermap.org/data/2.5/weather?q=Beijing",
                parameters: nil,
                success: {(operation:AFHTTPRequestOperation!,responseObject: AnyObject!) in
                    
                    self.resetButton()
                    var textContent =  String()
                    textContent +=  "请求结果\n"
                    
                    let json = JSONValue(responseObject)
                    
                    if let city = json["name"].string{
                        textContent +=  "City : \(city)\n"
                    }
                    
                    if let coord = json["coord"].object  {
                        
                        if let lonString = coord["lon"]?.double {
                            textContent +=  "lon : \(lonString)\n"
                        }
                        
                        if let latString = coord["lat"]?.double {
                            textContent +=  "lat : \(latString)\n"
                        }
                        
                    }
                    
                    textContent += "===========\n" + responseObject.description
                    
                    self.textView.text = textContent
                    
                },
                
                failure: {(operation:AFHTTPRequestOperation!,error:NSError!) in
                    
                    self.resetButton()
                    self.textView.text = "请求失败:\n" + error.localizedDescription
                    
                }
            )
        }
    }
    
    func resetButton(){
        progressView.stopAnimating()
        buttonView.setTitle("GET", forState: UIControlState.Normal)
    }
    
}

