//
//  ViewController.swift
//  HorseRaceLamp
//
//  Created by Ric on 5/10/17.
//  Copyright © 2017年 Ric. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    ///screenWidth
    let kScreenWidth = UIScreen.main.bounds.width;
    
    // screenHeight
    let kScreenHeight = UIScreen.main.bounds.height;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let horseLamp:HorseRaceLampView = HorseRaceLampView.init(frame: CGRect(x: 50, y: (kScreenHeight-20)/2, width: kScreenWidth-100, height: 20))
        horseLamp.text = "The spotted green pigeon is a species of pigeon that is most likely extinct. It was first mentioned and described in 1783 by John Latham"
        horseLamp.textColor = UIColor.orange
        horseLamp.font = UIFont.systemFont(ofSize: 14)
        self.view.addSubview(horseLamp);

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

