//
//  Extensions.swift
//  RewardForm
//
//  Created by Nikhil Desai on 28/08/21.
//

import Foundation
import UIKit

extension UIView {
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
    let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    self.layer.mask = mask
  }
}


extension UITextField{
    func setRightViewIcon(icon: UIImage)  -> UIButton {
        let btnView = UIButton(frame: CGRect(x: 0, y: 0, width: ((self.frame.height)/3), height: ((self.frame.height)/3)))
        btnView.setImage(icon, for: .normal)
        btnView.imageEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 10)
        btnView.tintColor = .white
        self.rightViewMode = .always
        self.rightView = btnView
        return btnView
    }
}

extension UIView {
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}



extension String {
    func validateLowercase() -> Bool {
        let lowercase = CharacterSet.lowercaseLetters

        let lowercaseRange = self.rangeOfCharacter(from: lowercase)

        return lowercaseRange != nil
    }
    
    func validateUppercase() -> Bool {
        let uppercase = CharacterSet.uppercaseLetters

        let uppercaseRange = self.rangeOfCharacter(from: uppercase)

        return uppercaseRange != nil
    }
}



extension UILabel {
    
    func setLineHeight(lineHeight: CGFloat) {
        let text = self.text
        if let text = text {
            let attributeString = NSMutableAttributedString(string: text)
            let style = NSMutableParagraphStyle()
            
            style.lineSpacing = lineHeight
            attributeString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSMakeRange(0, attributeString.length))
            self.attributedText = attributeString
        }
    }

}


extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

//MARK:- Emitter Class

class emitterAnimationCell:NSObject{
    static let shared = emitterAnimationCell()
    
    private override init() { }
    
    //MARK:- Confetti View Cell
    public func ConfettiEmitterCell(_ imageArray:[String],_ velocity: CGFloat) -> [CAEmitterCell]{
        var cells: [CAEmitterCell] = [CAEmitterCell]()
        
        for index in 0..<imageArray.count {
            let cell = CAEmitterCell()
            cell.birthRate = 4.0
            cell.lifetime = 14
            cell.lifetimeRange = 0
            cell.velocity = velocity
            cell.velocityRange = 0
            cell.emissionLongitude = CGFloat(Double.pi)
            cell.emissionRange = 0.5
            cell.spin = 3.5
            cell.spinRange = 0
            cell.contents = UIImage(named: imageArray[index])!.cgImage
            cell.scaleRange = 0.25
            cell.scale = 0.1
            cells.append(cell)
        }
        return cells
    }
}
