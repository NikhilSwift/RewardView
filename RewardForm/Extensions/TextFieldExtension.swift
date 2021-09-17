//
//  TextFieldExtension.swift
//  RewardForm
//
//  Created by Nikhil Desai on 05/09/21.
//

import UIKit


struct shadowProperties{
    var shadowRadius: CGFloat
    var shadowOffset: CGSize
    var shadowOpacity: Float
    var shadowColor: CGColor
}

struct viewBorder{
    var borderWidth: CGFloat
    var borderColor: CGColor
}

struct viewRadius{
    var radius: CGFloat
    var masktoBound: Bool
}



extension UIView{
    
    func setupView(backgroundColor: UIColor,with Radius:viewRadius?,with shadow:shadowProperties?,with Border:viewBorder?){
        self.backgroundColor = backgroundColor
        
        if let radiusData = Radius{
            self.layer.cornerRadius = radiusData.radius
            self.layer.masksToBounds = radiusData.masktoBound
        }
        
        if let borderData = Border{
            self.layer.borderWidth = borderData.borderWidth
            self.layer.borderColor = borderData.borderColor
        }
        
        if let shadowData = shadow, let radiusData = Radius{
            let shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: radiusData.radius).cgPath
            shadowLayer.fillColor = backgroundColor.cgColor
            shadowLayer.shadowColor = shadowData.shadowColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = shadowData.shadowOffset
            shadowLayer.shadowOpacity = shadowData.shadowOpacity
            shadowLayer.shadowRadius = shadowData.shadowRadius
            self.layer.insertSublayer(shadowLayer, at: 0)
        }
        
    }
    
}

extension UIImageView{
    
    func setupImageView(imageName:String,contentMode:UIView.ContentMode){
        self.image = UIImage(named: imageName)
        self.contentMode = contentMode
    }
    
}


extension UILabel{
    
    func setLabel(font:UIFont,alignment:NSTextAlignment,textColor:UIColor,numberofLines:Int){
        self.font = font
        self.textAlignment = alignment
        self.textColor = textColor
        self.numberOfLines = numberofLines
    }
    
    func setupAttriutedLabel(foreGroundColor:UIColor,backGroundColor:UIColor,font:UIFont){
        let attributed : [NSAttributedString.Key : Any] = [
            .foregroundColor: foreGroundColor,
            .backgroundColor: backGroundColor,
            .font: font,
        ]
        guard let textData = self.text else {return}
        let attributedString = NSAttributedString(string: textData, attributes: attributed)
        self.attributedText = attributedString
    }
    
}
