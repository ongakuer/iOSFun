//
//  ViewController.swift
//  navigation
//
//  Created by relex on 14-7-16.
//  Copyright (c) 2014年 relex. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let button = UIButton();
    let imageView = UIImageView();

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Home"
        
        let image = UIImage(named: "bridge.jpg");
        
        imageView.image = image
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        
        imageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(imageView)
        view.addConstraints([
            NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Width, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Height, multiplier: 1, constant: 0)
        ])
        
        button.setTitle("Next",  forState: UIControlState.Normal)
        button.titleLabel.font = UIFont(name: nil, size: 40)
        button.titleLabel.shadowOffset = CGSizeMake(0,1)
        button.setTitleColor(UIColor(white: 0, alpha: 0.8), forState: UIControlState.Normal)
        button.setTitleShadowColor(UIColor(white: 1, alpha: 0.8), forState: UIControlState.Normal)
        button.addTarget(self, action: "gotoFlower:", forControlEvents: UIControlEvents.TouchUpInside)
        button.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(button)
        view.addConstraints([
            NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 200),
            NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 200),
            NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.4, constant: 0),
            NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterY, multiplier:0.6, constant: 0)
        ])
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func gotoFlower(Send:UIButton){
        navigationController.pushViewController(FlowerController(), animated: true)
      }


}

