//
//  MenuViewController.swift
//  AKSwiftSlideMenu
//
//  Created by Ashish on 21/09/15.
//  Copyright (c) 2015 Kode. All rights reserved.
//

import UIKit

protocol SlideMenuDelegate {
    func slideMenuItemSelectedAtIndex(_ index : Int32)
}

class MenuViewController: UIViewController {
    
    @IBOutlet weak var expandableTableVIew: UITableView!
    
    @IBOutlet var btnCloseMenuOverlay : UIButton!
    var btnMenu : UIButton!
    var delegate : SlideMenuDelegate?
  
    var tableData = [TableData(title: "Title1", subTitle: ["subtile1", "subtile2"], isExpand: false),
                     TableData(title: "Title1", subTitle: ["subtile1", "subtile2", "subtile3"], isExpand: false),
                     TableData(title: "Title1", subTitle: ["subtile1", "subtile2","subtile3","subtile4"], isExpand: false),
                     TableData(title: "Title1", subTitle: ["subtile1", "subtile2","subtile3","subtile4","subtile5"], isExpand: false),
                     TableData(title: "Title1", subTitle: ["subtile1", "subtile2"], isExpand: false)
    ]

  
    override func viewDidLoad() {
        super.viewDidLoad()
        expandableTableVIew.tableFooterView = UIView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
  
  
  
    @IBAction func onCloseMenuClick(_ button:UIButton!){
        btnMenu.tag = 0
        
        if (self.delegate != nil) {
            var index = Int32(button.tag)
            if(button == self.btnCloseMenuOverlay){
                index = -1
            }
            delegate?.slideMenuItemSelectedAtIndex(index)
        }
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
            self.view.layoutIfNeeded()
            self.view.backgroundColor = UIColor.clear
            }, completion: { (finished) -> Void in
                self.view.removeFromSuperview()
              self.removeFromParent()
        })
    }
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = HeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        headerView.backgroundColor = #colorLiteral(red: 0.3098039329, green: 0.2039215714, blue: 0.03921568766, alpha: 1)
        headerView.delegate = self
        headerView.sectionIndex = section
        headerView.btn.setTitle(tableData[section].title, for: .normal)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableData[section].isExpand {
            return tableData[section].subTitle.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = expandableTableVIew.dequeueReusableCell(withIdentifier: "cells")
        cell?.textLabel?.text = tableData[indexPath.section].subTitle[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(tableData[indexPath.section].subTitle[indexPath.row])
        
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.tag = indexPath.row
        self.onCloseMenuClick(btn)
    }
}

extension MenuViewController: HeaderViewDelegate {
    func cellHeader(idx: Int) {
        tableData[idx].isExpand = !tableData[idx].isExpand
        expandableTableVIew.reloadSections([idx], with: .automatic)
    }
}






