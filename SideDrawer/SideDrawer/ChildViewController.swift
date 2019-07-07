//
//  ChildViewController.swift
//  SideDrawer
//
//  Created by RakeshPC on 07/07/19.
//  Copyright © 2019 RakeshPC. All rights reserved.
//

import UIKit

class ChildViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationSetting()
    }
    
    fileprivate func navigationSetting(){
        self.title = "Details"
        self.navigationItem.hidesBackButton = true
        
        let backBtnImg: UIImage = UIImage(named: "navback_icon")!
        let Back: UIBarButtonItem = UIBarButtonItem(image: backBtnImg, style: .plain, target: self, action: #selector(ChildViewController.backAction))
        navigationItem.leftBarButtonItem = Back
    }
    @objc func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
}
