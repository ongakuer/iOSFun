//
//  FlowerController.swift
//  navigation
//
//  Created by relex on 14-7-16.
//  Copyright (c) 2014年 relex. All rights reserved.
//

import UIKit

class FlowerController: UIViewController {
    let imageView = UIImageView();
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Flower"
        
        let image = UIImage(named: "flower.jpg");
        
        imageView.image = image
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        
        imageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        let  recognizer = UITapGestureRecognizer(target: self, action: "showAlert:")
        imageView.addGestureRecognizer(recognizer)
        imageView.userInteractionEnabled = true
        
        view.addSubview(imageView)
        view.addConstraints([
            NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Width, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Height, multiplier: 1, constant: 0)
            ])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    func showAlert(send:UIGestureRecognizer){
        
        let alert = UIAlertController(title: "Flower", message: "A flower, sometimes known as a bloom or blossom, is the reproductive structure found in flowering plants", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler:{ alert in
            
            println("Click OK")
            
            }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler:{ alert in
            
            println("Click Cancel")
            
            }))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    
}

