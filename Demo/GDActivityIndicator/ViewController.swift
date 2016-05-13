//
//  ViewController.swift
//  GDActivityIndicator
//
//  Created by Saeid Basirnia on 4/22/16.
//  Copyright © 2016 Saeidbsn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cView: GDIndicator!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: CGFloat(237 / 255.0), green: CGFloat(85 / 255.0), blue: CGFloat(101 / 255.0), alpha: 1)
        
        //load indicator with default values
        cView.circularDotsIndicator()
//        cView.circularDotsRotatingIndicator()
        
        //load indicator with custom values
//        cView.circularDotsIndicator(
//            15.0,
//            circleSpace: 7,
//            animDuration: 0.7,
//            shapeCol: UIColor.whiteColor(),
//            circleCount: 3,
//            colCount: 0)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

