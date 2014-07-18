//
//  ListController.swift
//  tableview
//
//  Created by relex on 14-7-17.
//  Copyright (c) 2014年 relex. All rights reserved.
//

import UIKit

class ListController: UIViewController ,UITableViewDelegate,UITableViewDataSource {
    
    var items: [String] = [
        "芒果",
        "牛肉",
        "橙汁",
        "桃干",
        "米糠",
        "番茄酱",
        "鸡肉",
        "茶",
        "咖啡豆",
        "杏仁",
        "栗子",
        "椰枣",
        "胡椒薄荷",
        "啤酒花",
        "草莓",
        "油桃"]
    
    let table = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "列表"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Bordered, target: nil, action: nil)
        
        table.setTranslatesAutoresizingMaskIntoConstraints(false)
        table.dataSource = self
        table.delegate = self
        
        view.addSubview(table)
        
        view.addConstraints([
            NSLayoutConstraint(item: table, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Width, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: table, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Height, multiplier: 1, constant: 0)
            ])
        
        let label = UILabel(frame: CGRectMake(0, 0, view.frame.width, 60))
        label.text = "点击下列词组查询翻译"
         label.font = UIFont(name: nil, size: 14)
        label.textColor = UIColor.whiteColor()
        label.backgroundColor = ColorStore.purpleLight() 
        label.textAlignment = NSTextAlignment.Center
        
        table.tableHeaderView = label
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        let cellIdentifier = "List"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? UITableViewCell
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
            
            let bgColorView = UIView()
            bgColorView.backgroundColor = ColorStore.purpleLightFade()
            cell!.selectedBackgroundView = bgColorView
        }
        
        cell!.textLabel.text = "\(indexPath.row + 1) " + items[indexPath.row]
        
        return cell!
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let detail = DetailController()
        detail.selectedItemString = items[indexPath.row]
        navigationController.pushViewController(detail, animated: true)
    }

}


