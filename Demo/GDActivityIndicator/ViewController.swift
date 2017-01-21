//
//  ViewController.swift
//  GDActivityIndicator
//
//  Created by Saeid Basirnia on 4/22/16.
//  Copyright © 2016 Saeidbsn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    enum IndicatorType{
        case blink
        case rotate
        case halfRotate
        case chain
        case circle
    }
    
    let viewsInRow: Int = 2
    
    override func viewDidLayoutSubviews() {
        //        self.view.showLoading(msg: "Please Wait")
        //        self.view.showLoading(onView: self.view, indicatorType: .normal, msg: "Please wait...", backgroundType: .clearWithBox)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.red.withAlphaComponent(0.7)
        
        let indicators: [IndicatorType] = [.blink, .rotate, .halfRotate, .chain, .circle]
        
        self.createViews(numberOfRows: Int((Double(indicators.count) / Double(viewsInRow)).rounded(.up)), lst: indicators)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func createViews(numberOfRows: Int, lst: [IndicatorType]){
        var indicatorView: UIView!
        var indicators = [UIView]()
        
        for itm in lst{
            switch itm{
            case .blink:
                indicatorView = GDCircularDotsBlinking()
                indicatorView.translatesAutoresizingMaskIntoConstraints = false
                indicators.append(indicatorView)
                
                self.view.addSubview(indicatorView)
                break
            case .chain:
                indicatorView = GDCircularDotsChain()
                indicatorView.translatesAutoresizingMaskIntoConstraints = false
                indicators.append(indicatorView)
                
                self.view.addSubview(indicatorView)
                break
            case .halfRotate:
                indicatorView = GDHalfCircleRotating()
                indicatorView.translatesAutoresizingMaskIntoConstraints = false
                indicators.append(indicatorView)
                
                self.view.addSubview(indicatorView)
                break
            case .rotate:
                indicatorView = GDCircularDotsRotating()
                indicatorView.translatesAutoresizingMaskIntoConstraints = false
                indicators.append(indicatorView)
                
                self.view.addSubview(indicatorView)
                break
            case .circle:
                indicatorView = GDCircle()
                indicatorView.translatesAutoresizingMaskIntoConstraints = false
                indicators.append(indicatorView)
                
                self.view.addSubview(indicatorView)
            }
        }
        setupConstraints(totalRows: numberOfRows, views: indicators)
    }
    
    func setupConstraints(totalRows: Int, views: [UIView]){
        var row = 0
        var itemsInRow = 0
        
        for itm in views{
            if itemsInRow < viewsInRow{
                constraintHelper(itm: itm, totalRows: totalRows, itemsInRow: itemsInRow, row: row)
                itemsInRow += 1
            }else{
                row += 1
                itemsInRow = 0
                constraintHelper(itm: itm, totalRows: totalRows, itemsInRow: itemsInRow, row: row)
                itemsInRow += 1
            }
        }
    }
    
    func constraintHelper(itm: UIView, totalRows: Int, itemsInRow: Int, row: Int){
        let top: NSLayoutConstraint = NSLayoutConstraint(item: itm, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: self.view.frame.height / CGFloat(totalRows) * CGFloat(row))
        let left: NSLayoutConstraint = NSLayoutConstraint(item: itm, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1, constant: (self.view.frame.width / CGFloat(viewsInRow)) * CGFloat(itemsInRow))
        let height: NSLayoutConstraint = NSLayoutConstraint(item: itm, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: self.view.frame.height / CGFloat(totalRows))
        let width: NSLayoutConstraint = NSLayoutConstraint(item: itm, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: self.view.frame.width / CGFloat(viewsInRow))
        
        if itemsInRow == viewsInRow - 1{
            let right: NSLayoutConstraint = NSLayoutConstraint(item: itm, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1, constant: 0)
            
            self.view.addConstraint(right)
        }
        
        self.view.addConstraints([top, left, height, width])
    }
}

