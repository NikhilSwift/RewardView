//
//  ProgressView.swift
//  RewardForm
//
//  Created by Nikhil Desai on 29/08/21.
//

import UIKit

class ProgressView: UIView {
    let lineLayer = CAShapeLayer()
    let linePath = UIBezierPath()
    //
    let circularLayer = CAShapeLayer()
    var circularPath : UIBezierPath?
    var circularRadius: CGFloat = 20
    var circularColor = UIColor(red: 51/255, green: 50/255, blue: 51/255, alpha: 1)
    var inProgress: ProgressType?{
        didSet{
            if let set = inProgress{
                print(set,"cell")
                if set == .InProgress{
                    self.animateCircular()
                }else if set == .Completed{
                    self.circularColor = .white
                    self.circularLayer.removeAllAnimations()
                }else if set == .UpComing{
                    self.circularLayer.removeAllAnimations()
                }
                self.layoutIfNeeded()
            }
        }
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setupLineLayer()
        setupCircularLayer()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLineLayer()
        setupCircularLayer()
    }
    
    func setupLineLayer(){
        linePath.move(to: .init(x: self.frame.width/2, y: 0))
        linePath.addLine(to: .init(x: self.frame.width/2, y: self.frame.height))
        lineLayer.path = linePath.cgPath
        lineLayer.frame = self.bounds
        lineLayer.lineWidth = 1
        lineLayer.strokeColor = UIColor.white.cgColor
        self.layer.addSublayer(lineLayer)
    }
    
    func setupCircularLayer(){
        circularPath = UIBezierPath(ovalIn: .init(x: self.frame.width/2 - circularRadius/2, y: self.frame.height/2 - circularRadius/2, width: circularRadius, height: circularRadius))
        circularLayer.path = circularPath?.cgPath
        circularLayer.frame = self.bounds
        circularLayer.lineWidth = 1
        circularLayer.strokeColor = UIColor.white.cgColor
        circularLayer.fillColor = circularColor.cgColor
        self.layer.addSublayer(circularLayer)
    }
    
    func animateCircular(){
        let scalePositionAnimation = CABasicAnimation(keyPath: "transform.scale")
        scalePositionAnimation.delegate = self
        scalePositionAnimation.duration = 1
        scalePositionAnimation.toValue = CGAffineTransform(scaleX: 1.7, y: 1.7)
        scalePositionAnimation.timingFunction = .init(name: .easeInEaseOut)
        scalePositionAnimation.repeatCount = .infinity
        scalePositionAnimation.setValue("scalePositionAnimation", forKey: "scalePositionAnimation")
        circularLayer.fillColor = UIColor.white.cgColor
        circularLayer.add(scalePositionAnimation, forKey: nil)
    }
}


extension ProgressView: CAAnimationDelegate{
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
    }
}
