//
//  DetailController.swift
//  tableview
//
//  Created by relex on 14-7-17.
//  Copyright (c) 2014年 relex. All rights reserved.
//

import UIKit


class DetailController: UIViewController {
    
    var selectedItemString:String?
    
    let label = UILabel()
    let symbol = UILabel()
    let line = UIView()
    let progress = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
    let text = UITextView()
    let afHttpManager = AFHTTPSessionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = (selectedItemString == nil ? "Detail" : "\(selectedItemString!)")
        view.backgroundColor = UIColor.whiteColor()
        edgesForExtendedLayout = UIRectEdge.None
        
        if selectedItemString != nil {
            initWordView(selectedItemString!)
            initRequestWord(selectedItemString!)
        }
    }
    
    
    func initWordView(word:String){
        
       
        
        
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        label.text = word
        label.font = UIFont(name: nil, size: 40)
        label.textColor = UIColor.darkTextColor()
        view.addSubview(label)
        view.addConstraints([
            NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: 20),
            NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 40),
            NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 40)
            ])
        
        symbol.setTranslatesAutoresizingMaskIntoConstraints(false)
        symbol.font = UIFont(name: nil, size: 16)
        symbol.textColor =  ColorStore.purpleLight()
        view.addSubview(symbol)
        view.addConstraints([
            NSLayoutConstraint(item: symbol, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: label, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: 10),
            NSLayoutConstraint(item: symbol, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: label, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: -2),
            NSLayoutConstraint(item: symbol, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 18)
            ])
        
        line.setTranslatesAutoresizingMaskIntoConstraints(false)
        line.backgroundColor = ColorStore.purpleLightFade()
        view.addSubview(line)
        view.addConstraints([
            NSLayoutConstraint(item: line, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: 20),
            NSLayoutConstraint(item: line, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: 20),
            NSLayoutConstraint(item: line, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Width, multiplier: 1, constant: -40),
            NSLayoutConstraint(item: line, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: symbol, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 20),
            NSLayoutConstraint(item: line, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 1)
            ])
        line.hidden = true
        
        progress.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(progress)
        view.addConstraints([
            NSLayoutConstraint(item: progress, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: label, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: 10),
            NSLayoutConstraint(item: progress, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: label, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0),
            ])
        
        progress.startAnimating()
        
        
        text.setTranslatesAutoresizingMaskIntoConstraints(false)
        text.editable = false
        text.textColor = ColorStore.purpleDark()
        text.font = UIFont(name: nil, size: 16)
        text.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        view.addSubview(text)
        view.addConstraints([
            NSLayoutConstraint(item: text, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: 20),
            NSLayoutConstraint(item: text, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: -20),
            NSLayoutConstraint(item: text, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: line, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 10),
            NSLayoutConstraint(item: text, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: -20),
            ])
    }
    
    
    func initRequestWord(word:String){
        
        afHttpManager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/html"])
        
        let parameters = ["w":word,"type":"json","key":"2C1A35F83056CBB015965763A09A80E8" ]
        
        afHttpManager.GET("http://dict-co.iciba.com/api/dictionary.php", parameters: parameters,
            success: { ( dataTask:NSURLSessionDataTask!, response:AnyObject!) in
                
               
                self.parseResponse(response)
                
            }, failure: {(dataTask:NSURLSessionDataTask!, nsError:NSError!) in
                
                self.progress.stopAnimating()
                print( "请求出错 : " + nsError.description)
            })
    }
    
    func parseResponse(response:AnyObject!){
        
        progress.stopAnimating()
        
        let json = JSONValue(response)
        
        if let symbolsObject = json["symbols"][0].object {
            
            
            
            if let wordSymbol = symbolsObject["word_symbol"]?.string{
                
                let wordSymbolTrim =  trim(wordSymbol)
                
                if wordSymbolTrim != "" {
                    symbol.text = "[ \(wordSymbol) ]"
                }
                
                line.hidden = false
            }
            
            if let parts = symbolsObject["parts"]?.first{

                if let meansArray = parts["means"].array{
                    var textContent:String = String()
                    var index = 0
                    for mean in meansArray{
                        index++
                        if let meanString = mean["word_mean"].string{
                            textContent += "\(index). \(meanString)\n"
                        }
                    }
                    
                    if index > 0 {
                        text.text = textContent
                    }
                }
            }
        }
    }
    
    
    func trim(text:String)->String{
        return text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }
    
    
    
    
    
}
