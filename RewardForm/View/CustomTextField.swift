//
//  CustomTextField.swift
//  RewardForm
//
//  Created by Nikhil Desai on 27/08/21.
//

import Foundation


import UIKit

class CustomTextField: UITextField{
    var title: String?
    var placeholderText: String?
    var image: String?
    
    init(frame: CGRect, title:String?, icon:String?, placeholder: String?) {
        self.title = title
        self.image = icon
        self.placeholderText = placeholder
        super.init(frame: frame)
    }
    
    //MARK:- Setup Textfield
    func setupTextfield(){
        self.placeholder = placeholderText
        self.font = .systemFont(ofSize: 20, weight: .semibold)
    }
    
    //MARK:- Setup Title
    func setupTitle(){
        
    }
    
    //MARK:- Setup Icon
    func setupIcon(){
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
