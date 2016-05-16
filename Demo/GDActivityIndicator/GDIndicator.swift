//
//  DotCircularIndicator.swift
//  GDActivityIndicator
//
//  Created by Saeid Basirnia on 4/22/16.
//  Copyright © 2016 Saeidbsn. All rights reserved.
//

import UIKit

class GDIndicator: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    private func setupView(){
        self.backgroundColor = UIColor.clearColor()
    }
    
    /*!
     Simple circular animation
     
     - parameter circleRadius: radius of circles
     - parameter circleSpace:  space between each circle
     - parameter animDuration: animation duration
     - parameter shapeCol:     color of circles
     - parameter circleCount:  number of circles in a row
     - parameter colCount:     number of columns
     */
    func circularDotsIndicator(
        circleRadius: CGFloat = 5.0,
        circleSpace: CGFloat = 7,
        animDuration: CFTimeInterval = 0.7,
        shapeCol: UIColor = UIColor.whiteColor(),
        circleCount: Int = 3,
        colCount: Int = 0){
        
        //Setting properties
        let circleStart: CGFloat = 0.0
        let circleEnd: CGFloat = CGFloat(M_PI * 2)
        let animTime = CACurrentMediaTime()
        let animTimes = [0.0, 0.5, 0.8, 1, 1.2, 1.26, 1.4, 1.6, 1.9, 2.1, 2.4, 2.8]
        
        //Create Circle bezier path
        let path = UIBezierPath(arcCenter: CGPointZero, radius: circleRadius, startAngle: circleStart, endAngle: circleEnd, clockwise: true)
        
        //Calculate position of circles
        let size = (2 * circleRadius) * CGFloat(circleCount / 2)
        let x = (layer.bounds.width) / 2 - size
        let y = layer.bounds.height / 2
        
        //Add animations
        //Fade animation
        let fadeAnim = CABasicAnimation(keyPath: "opacity")
        fadeAnim.fromValue = 0.5
        fadeAnim.toValue = 1.0
        fadeAnim.duration = animDuration
        
        //X animation scale
        let xAnim = CAKeyframeAnimation(keyPath: "transform.scale.x")
        xAnim.values = [0.7, 1, 0.7]
        xAnim.keyTimes = [0.3, 0.6, 1]
        
        //Y animation scale
        let yAnim = CAKeyframeAnimation(keyPath: "transform.scale.y")
        yAnim.values = [0.7, 1, 0.7]
        yAnim.keyTimes = [0.3, 0.6, 1]
        
        let groupAnim = CAAnimationGroup()
        groupAnim.duration = animDuration
        groupAnim.removedOnCompletion = false
        groupAnim.repeatCount = HUGE
        groupAnim.animations = [fadeAnim, xAnim, yAnim]
        
        //Create n shapes with animations
        if colCount != 0{
            for i in 0..<circleCount{
                for j in 0..<colCount{
                    //Create Shape for path
                    let shapeToAdd = CAShapeLayer()
                    shapeToAdd.fillColor = shapeCol.CGColor
                    shapeToAdd.strokeColor = nil
                    shapeToAdd.path = path.CGPath
                    
                    let frame = CGRectMake(
                        (x + circleRadius * CGFloat(i) + circleSpace * CGFloat(i)),
                        (y + circleRadius * CGFloat(j) + circleSpace * CGFloat(j)),
                        circleRadius,
                        circleRadius)
                    shapeToAdd.frame = frame
                    
                    groupAnim.beginTime = animTime + animTimes[i]
                    
                    layer.addSublayer(shapeToAdd)
                    shapeToAdd.addAnimation(groupAnim, forKey: "circularDotsIndicator")
                }
            }
        }else{
            for i in 0..<circleCount{
                //Create Shape for path
                let shapeToAdd = CAShapeLayer()
                shapeToAdd.fillColor = shapeCol.CGColor
                shapeToAdd.strokeColor = nil
                shapeToAdd.path = path.CGPath
                
                let frame = CGRectMake(
                    (x + circleRadius * CGFloat(i) + circleSpace * CGFloat(i)),
                    y,
                    circleRadius,
                    circleRadius)
                shapeToAdd.frame = frame
                
                groupAnim.beginTime = animTime + animTimes[i]
                
                layer.addSublayer(shapeToAdd)
                shapeToAdd.addAnimation(groupAnim, forKey: "circularDotsIndicator")
            }
        }
    }
    
    /*!
     4 circle rotating/switching animation
     
     - parameter circleRadius:           radius of circles
     - parameter circleSpace:            space between circles
     - parameter animDuration:           duration of each interval of animation
     - parameter topLeftCircleColor:     top-left circle color
     - parameter topRightCircleColor:    top-right circle color
     - parameter bottomLeftCircleColor:  bottom-left circle color
     - parameter bottomRightCircleColor: bottom-right circle color
     */
    func circularDotsRotatingIndicator(
        circleRadius: CGFloat = 9.0,
        circleSpace: CGFloat = 50,
        animDuration: CFTimeInterval = 3,
        topLeftCircleColor: UIColor = UIColor.whiteColor(),
        topRightCircleColor: UIColor = UIColor.blackColor(),
        bottomLeftCircleColor: UIColor = UIColor.blackColor(),
        bottomRightCircleColor: UIColor = UIColor.whiteColor()){
        
        //Setting properties
        let circleStart: CGFloat = 0.0
        let circleEnd: CGFloat = CGFloat(M_PI * 2)
        let animTime = CACurrentMediaTime()
        
        //Calculate possition for each circle in different directions
        let center = CGPointMake(bounds.width / 2, bounds.height / 2)
        let topLeft = CGPointMake(0 + circleSpace, 0 + circleSpace)
        let topRight = CGPointMake(bounds.width - circleSpace, 0 + circleSpace)
        let bottomLeft = CGPointMake(0 + circleSpace, bounds.height - circleSpace)
        let bottomRight = CGPointMake(bounds.width - circleSpace, bounds.height - circleSpace)
        let circleSize = CGSizeMake(circleRadius, circleRadius)
        
        let lineWidth: CGFloat = 3.0
        let timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        
        //Create Circle bezier path
        let path = UIBezierPath(arcCenter: CGPointZero, radius: circleRadius, startAngle: circleStart, endAngle: circleEnd, clockwise: true)
        
        //Top Left circle shape
        let topLeftCircle = CAShapeLayer()
        topLeftCircle.fillColor = topLeftCircleColor.CGColor
        topLeftCircle.strokeColor = topLeftCircleColor.CGColor
        topLeftCircle.strokeStart = 0.0
        topLeftCircle.strokeEnd = 1.0
        topLeftCircle.lineWidth = lineWidth
        topLeftCircle.path = path.CGPath
        topLeftCircle.frame = CGRect(origin: topLeft, size: circleSize)
        
        layer.addSublayer(topLeftCircle)
        
        //Top right circle shape
        let topRightCircle = CAShapeLayer()
        topRightCircle.fillColor = topRightCircleColor.CGColor
        topRightCircle.strokeColor = topRightCircleColor.CGColor
        topRightCircle.strokeStart = 0.0
        topRightCircle.strokeEnd = 1.0
        topRightCircle.lineWidth = lineWidth
        topRightCircle.path = path.CGPath
        topRightCircle.frame = CGRect(origin: topRight, size: circleSize)
        
        layer.addSublayer(topRightCircle)
        
        //bottom Left circle shape
        let bottomLeftCircle = CAShapeLayer()
        bottomLeftCircle.fillColor = bottomLeftCircleColor.CGColor
        bottomLeftCircle.strokeColor = bottomLeftCircleColor.CGColor
        bottomLeftCircle.strokeStart = 0.0
        bottomLeftCircle.strokeEnd = 1.0
        bottomLeftCircle.lineWidth = lineWidth
        bottomLeftCircle.path = path.CGPath
        bottomLeftCircle.frame = CGRect(origin: bottomLeft, size: circleSize)
        
        layer.addSublayer(bottomLeftCircle)
        
        //bottom right circle shape
        let bottomRightCircle = CAShapeLayer()
        bottomRightCircle.fillColor = bottomRightCircleColor.CGColor
        bottomRightCircle.strokeColor = bottomRightCircleColor.CGColor
        bottomRightCircle.strokeStart = 0.0
        bottomRightCircle.strokeEnd = 1.0
        bottomRightCircle.lineWidth = lineWidth
        bottomRightCircle.path = path.CGPath
        bottomRightCircle.frame = CGRect(origin: bottomRight, size: circleSize)
        
        layer.addSublayer(bottomRightCircle)
        
        //Rotate animation
        let rotateAnim = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        rotateAnim.values = [0, M_PI , M_PI * 2]
        rotateAnim.keyTimes = [0.0, 0.4, 1]
        rotateAnim.repeatCount = HUGE
        rotateAnim.duration = animDuration / 2
        rotateAnim.removedOnCompletion = false
        rotateAnim.timingFunctions = [timingFunction, timingFunction, timingFunction]
        
        layer.addAnimation(rotateAnim, forKey: nil)
        
        //Translate position animation
        let transAnim = CAKeyframeAnimation(keyPath: "position")
        transAnim.duration = animDuration
        transAnim.keyTimes = [0.0, 0.3, 0.5, 0.7, 1]
        transAnim.removedOnCompletion = false
        transAnim.timingFunctions = [timingFunction, timingFunction, timingFunction, timingFunction]
        transAnim.repeatCount = HUGE
        
        func setTransisionValues(shapeToAdd: CAShapeLayer, values: [CGPoint]){
            transAnim.values = [NSValue(CGPoint: values[0]), NSValue(CGPoint: values[1]), NSValue(CGPoint: values[2]), NSValue(CGPoint: values[3]), NSValue(CGPoint: values[4])]
            shapeToAdd.addAnimation(transAnim, forKey: "circularDotsRotatingIndicator")
        }
        
        setTransisionValues(topLeftCircle, values: [topLeft, center, bottomRight, center, topLeft])
        setTransisionValues(topRightCircle, values: [topRight, center, bottomLeft, center, topRight])
        setTransisionValues(bottomLeftCircle, values: [bottomLeft, center, topRight, center, bottomLeft])
        setTransisionValues(bottomRightCircle, values: [bottomRight, center, topLeft, center, bottomRight])
    }
    
    /*!
     Chain rotation of circles
     
     - parameter circleRadius:     circle radius and circles size
     - parameter radiusMultiplier: radius of the rotation path. bigger values means bigger rotation area
     - parameter animDuration:     duration of a full rotation
     */
    func circularDotsRotatingChain(
        circleRadius: CGFloat = 5.0,
        radiusMultiplier: CGFloat = 5,
        animDuration: CFTimeInterval = 2.0){
        
        var circleShape: CAShapeLayer!
        let circleStart: CGFloat = 0.0
        let circleEnd: CGFloat = CGFloat(M_PI * 2)
        var animRate: Float = 0.0
        
        for i in 0...4{
            animRate = Float(i) * 1.7 / 8
            
            let circlePath = UIBezierPath(arcCenter: CGPointMake(self.bounds.width / 2, self.bounds.height / 2), radius: circleRadius * 0.4 + CGFloat(i), startAngle: circleStart, endAngle: circleEnd, clockwise: true).CGPath
            
            circleShape = CAShapeLayer()
            circleShape.path = circlePath
            circleShape.fillColor = UIColor.whiteColor().CGColor
            
            let posAnim = CAKeyframeAnimation(keyPath: "position")
            posAnim.path = UIBezierPath(arcCenter: CGPoint(x: 0, y: 0), radius: circleRadius * radiusMultiplier, startAngle: circleStart - CGFloat(M_PI_2), endAngle: circleEnd + circleStart - CGFloat(M_PI_2), clockwise: true).CGPath
            
            
            posAnim.repeatCount = HUGE
            posAnim.duration = animDuration
            posAnim.timingFunction = CAMediaTimingFunction(controlPoints: 0.5, 0.15 + animRate, 0.05, 1.0)
            posAnim.removedOnCompletion = true
            
            circleShape.addAnimation(posAnim, forKey: nil)
            layer.addSublayer(circleShape)
        }
    }
    
    func halfCircleRotating(){
        let circleRadius: CGFloat = 20.0
        let animDuration: CFTimeInterval = 3
        
        //Setting properties
        let circleStart: CGFloat = 0.0
        let circleEnd: CGFloat = CGFloat(M_PI * 2)
        let animDelay = 1.6
        
        //Calculate possition for each circle in different directions
        let center = CGPointMake(bounds.width / 2, bounds.height / 2)
        
        let circlePath = UIBezierPath()
        circlePath.addArcWithCenter(center, radius: circleRadius, startAngle: circleStart, endAngle: circleEnd, clockwise: true)
        let circlePath1 = UIBezierPath()
        circlePath1.addArcWithCenter(center, radius: circleRadius - 3.0, startAngle: circleStart, endAngle: circleEnd, clockwise: false)
        let circlePathCenter = UIBezierPath()
        circlePathCenter.addArcWithCenter(center, radius: circleRadius - 8.0, startAngle: circleStart, endAngle: circleEnd, clockwise: true)
        
        let circleShape = CAShapeLayer()
        circleShape.path = circlePath.CGPath
        circleShape.fillColor = nil
        circleShape.strokeColor = UIColor.whiteColor().CGColor
        circleShape.lineWidth = 2.0
        circleShape.strokeStart = 0.0
        circleShape.strokeEnd = 0.0
        
        let circleShape1 = CAShapeLayer()
        circleShape1.path = circlePath1.CGPath
        circleShape1.fillColor = nil
        circleShape1.strokeColor = UIColor.whiteColor().CGColor
        circleShape1.lineWidth = 2.0
        circleShape1.strokeStart = 0.0
        circleShape1.strokeEnd = 0.0

        let circleShapeCenter = CAShapeLayer()
        circleShapeCenter.path = circlePathCenter.CGPath
        circleShapeCenter.fillColor = UIColor.whiteColor().CGColor

        let rotateAnim = CABasicAnimation(keyPath: "transform.rotation.z")
        rotateAnim.duration = animDuration * 2.3
        rotateAnim.fromValue = circleStart
        rotateAnim.toValue = circleEnd
        rotateAnim.repeatCount = HUGE
        layer.addAnimation(rotateAnim, forKey: nil)
        
        let drawAnim = CABasicAnimation(keyPath: "strokeEnd")
        drawAnim.fromValue = 0.0
        drawAnim.toValue = 1.0
        drawAnim.duration = animDuration
        
        let eraseAnim = CABasicAnimation(keyPath: "strokeStart")
        eraseAnim.fromValue = 0.0
        eraseAnim.toValue = 1.0
        eraseAnim.beginTime = animDelay
        eraseAnim.duration = animDuration - animDelay
        
        let groupAnim = CAAnimationGroup()
        groupAnim.animations = [drawAnim, eraseAnim]
        groupAnim.repeatCount = HUGE
        groupAnim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        groupAnim.removedOnCompletion = false
        groupAnim.duration = animDuration
        
        let drawAnim1 = CABasicAnimation(keyPath: "strokeEnd")
        drawAnim1.fromValue = 0.0
        drawAnim1.toValue = 1.0
        drawAnim1.duration = animDuration
        
        let eraseAnim1 = CABasicAnimation(keyPath: "strokeStart")
        eraseAnim1.fromValue = 0.0
        eraseAnim1.toValue = 1.0
        eraseAnim1.beginTime = animDelay
        eraseAnim1.duration = animDuration - animDelay
        
        let groupAnim1 = CAAnimationGroup()
        groupAnim1.animations = [drawAnim1, eraseAnim1]
        groupAnim1.repeatCount = HUGE
        groupAnim1.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        groupAnim1.removedOnCompletion = false
        groupAnim1.duration = animDuration
        
        circleShape.addAnimation(groupAnim, forKey: nil)
        layer.addSublayer(circleShape)
        circleShape1.addAnimation(groupAnim1, forKey: nil)
        layer.addSublayer(circleShape1)
        layer.addSublayer(circleShapeCenter)
    }
    
    
    
    
    
    
    
    
    
    
    
}
