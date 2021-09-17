//
//  RewardFormView.swift
//  RewardForm
//
//  Created by Nikhil Desai on 27/08/21.
//

import Foundation
import UIKit

protocol textfieldDataprotocol{
    func textfieldData(_ tag: Int)
}

class RewardFormView: UIView{
    let topView = UIView()
    let topTextfieldView = UIView()
    let passwordTextfieldView = UIView()
    let countryTextfieldView = UIView()
    let titleLbl = UILabel()
    let emalTitleLbl = UILabel()
    let emailTextfield = UITextField()
    let passwordTitleLbl = UILabel()
    let passwordTextfield = UITextField()
    let passwordRequirmentTitle = UILabel()
    let passwordLowerCaseTitle = UILabel()
    let passwordHigherCaseTitle = UILabel()
    let passwordNumberTitle = UILabel()
    let passwordCharacterTitle = UILabel()
    let countryTitleLbl = UILabel()
    let countryTextfield = UITextField()
    let progressTableView = UITableView()
    let registerButton = UIButton()
    let pickerView = UIPickerView(frame: .init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 240))
    let toolBar = UIToolbar()
    let rewardImageView = UIImageView()
    let rewardSuccessLbl = UILabel()
    var emiterLayer = CAEmitterLayer()
    var textfieldRadius : CGFloat = 10
    var topViewHeight : CGFloat = UIScreen.main.bounds.height
    var textfieldViewHeight : CGFloat = 100
    var registerButtonHeight : CGFloat = 50
    var topViewheightConstraint = NSLayoutConstraint()
    var emailViewTopConstraint = NSLayoutConstraint()
    var topviewMultiplier: CGFloat = 3
    var selectedTextfieldData : textfieldDataprotocol?
    let coffetiImages = ["confetti-5","coupon","discount","medal"]
    var currentTextfield : textfieldType?{
        didSet{
            self.populateTextfields()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        SetupTextfieldTopView()
        setupConstraints()
        setupToolBar()
    }
    
    func setupView(){
        self.backgroundColor = UIColor(red: 52/255, green: 51/255, blue: 58/255, alpha: 1)
    }
    
    func SetupTextfieldTopView(){
        titleLbl.text = "Register"
        titleLbl.font = .systemFont(ofSize: 28, weight: .semibold)
        titleLbl.numberOfLines = 0
        
        topView.backgroundColor = UIColor(red: 34/255, green: 33/255, blue: 39/255, alpha: 1)
        topView.layer.masksToBounds  = true
        topView.layer.cornerRadius  =  20
        topTextfieldView.backgroundColor = .clear
        countryTextfieldView.backgroundColor = .clear
        emalTitleLbl.text = "Email"
        passwordTitleLbl.text = "Pasword"
        countryTitleLbl.text = "Country"
        [emalTitleLbl,passwordTitleLbl,countryTitleLbl].forEach { (textfieldtitle) in
            textfieldtitle.font = .systemFont(ofSize: 20, weight: .light)
            textfieldtitle.numberOfLines = 1
        }
        [emailTextfield,passwordTextfield,countryTextfield].forEach { (textfields) in
            textfields.backgroundColor  = UIColor(red: 51/255, green: 50/255, blue: 51/255, alpha: 1)
            textfields.font = .systemFont(ofSize: 18, weight: .semibold)
            textfields.textColor = .white
            textfields.layer.borderColor = UIColor.white.withAlphaComponent(0.7).cgColor
            textfields.layer.borderWidth = 0.5
            textfields.layer.masksToBounds = false
            textfields.layer.cornerRadius = textfieldRadius
            textfields.setRightViewIcon(icon: UIImage(named: "arrow-right")!).addTarget(self, action: #selector(sendSelectedTextfielddata(_:)), for: .touchUpInside)
            textfields.setLeftPaddingPoints(20)
        }
        emailTextfield.placeholder = "   Enter your Email Id"
        emailTextfield.tag = 0
        //
        passwordTextfield.placeholder = "   Set your Password"
        passwordTextfield.tag = 1
        //
        countryTextfield.placeholder = "   Select your Country"
        countryTextfield.tag = 2
        countryTextfield.inputView = pickerView
        //
        passwordRequirmentTitle.text = "Password must contain :"
        passwordRequirmentTitle.font = .systemFont(ofSize: 15, weight: .light)
        passwordRequirmentTitle.textColor = UIColor.white.withAlphaComponent(0.5)
        //
        [passwordLowerCaseTitle,passwordHigherCaseTitle,passwordNumberTitle,passwordCharacterTitle].forEach { (passwordLbls) in
            passwordLbls.font = .systemFont(ofSize: 14, weight: .regular)
            passwordLbls.numberOfLines = 1
            passwordLbls.textColor = UIColor.white.withAlphaComponent(0.5)
        }
        passwordLowerCaseTitle.text = "lower-case"
        passwordHigherCaseTitle.text = "upper-case"
        passwordNumberTitle.text = "numbers"
        passwordCharacterTitle.text = "8-16 characters"
        //
        progressTableView.backgroundColor = .white
        progressTableView.separatorStyle = .none
        progressTableView.showsHorizontalScrollIndicator = false
        //
        registerButton.setTitle("Register", for: .normal)
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.layer.cornerRadius = 10
        registerButton.layer.masksToBounds = true
        registerButton.backgroundColor = UIColor(red: 34/255, green: 33/255, blue: 39/255, alpha: 1)
        //
        rewardImageView.image  = UIImage(named: "reward")
        rewardImageView.contentMode = .scaleAspectFit
        //
        rewardSuccessLbl.text = "You have Recieved \n\n1500/- Coupon"
        rewardSuccessLbl.textColor = .white
        rewardSuccessLbl.font  =  .systemFont(ofSize: 28, weight: .heavy)
        rewardSuccessLbl.textAlignment = .center
        rewardSuccessLbl.numberOfLines  = 0
    }
    
    func setupConstraints(){
        self.addSubview(topView)
        self.addSubview(progressTableView)
        self.addSubview(registerButton)
        topView.addSubview(titleLbl)
        topView.addSubview(topTextfieldView)
        topView.addSubview(passwordTextfieldView)
        topView.addSubview(countryTextfieldView)
        topView.addSubview(rewardImageView)
        topView.addSubview(rewardSuccessLbl)
        //
        topTextfieldView.addSubview(emalTitleLbl)
        topTextfieldView.addSubview(emailTextfield)
        //
        countryTextfieldView.addSubview(countryTitleLbl)
        countryTextfieldView.addSubview(countryTextfield)
        //
        [passwordTitleLbl,passwordTextfield,passwordRequirmentTitle,passwordLowerCaseTitle,passwordHigherCaseTitle,passwordNumberTitle,passwordCharacterTitle].forEach { (passwordviews) in
            passwordTextfieldView.addSubview(passwordviews)
        }
        //
        [topView,titleLbl,topTextfieldView,emailTextfield,emalTitleLbl,passwordTextfieldView,passwordTitleLbl,passwordTextfield,passwordRequirmentTitle,passwordLowerCaseTitle,passwordHigherCaseTitle,passwordNumberTitle,passwordCharacterTitle,countryTextfieldView,countryTitleLbl,countryTextfield,progressTableView,registerButton,rewardImageView,rewardSuccessLbl].forEach { (subviews) in
            subviews.translatesAutoresizingMaskIntoConstraints = false
        }
        
        topView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        topView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        topView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        self.topViewheightConstraint =  topView.heightAnchor.constraint(equalToConstant: topViewHeight/topviewMultiplier)
        self.topViewheightConstraint.isActive = true
        //
        titleLbl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        titleLbl.topAnchor.constraint(equalTo: self.topAnchor, constant: 80).isActive = true
        titleLbl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        //
        topTextfieldView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        emailViewTopConstraint = topTextfieldView.topAnchor.constraint(equalTo: self.titleLbl.bottomAnchor, constant: 20)
        emailViewTopConstraint.isActive = true
        topTextfieldView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        topTextfieldView.heightAnchor.constraint(equalToConstant: textfieldViewHeight).isActive = true
        //
        emalTitleLbl.leadingAnchor.constraint(equalTo: self.topTextfieldView.leadingAnchor, constant: 20).isActive = true
        emalTitleLbl.topAnchor.constraint(equalTo: self.topTextfieldView.topAnchor, constant: 20).isActive = true
        emalTitleLbl.trailingAnchor.constraint(equalTo: self.topTextfieldView.trailingAnchor, constant: -20).isActive = true
        //
        emailTextfield.leadingAnchor.constraint(equalTo: self.topTextfieldView.leadingAnchor, constant: 20).isActive = true
        emailTextfield.trailingAnchor.constraint(equalTo: self.topTextfieldView.trailingAnchor, constant: -20).isActive = true
        emailTextfield.topAnchor.constraint(equalTo: self.emalTitleLbl.bottomAnchor, constant: 15).isActive = true
        emailTextfield.heightAnchor.constraint(equalToConstant: 50).isActive = true
        //
        //
        passwordTextfieldView.leadingAnchor.constraint(equalTo: self.topView.leadingAnchor, constant: 0).isActive = true
        passwordTextfieldView.topAnchor.constraint(equalTo: self.titleLbl.bottomAnchor, constant: 20).isActive = true
        passwordTextfieldView.trailingAnchor.constraint(equalTo: self.topView.trailingAnchor, constant: 0).isActive = true
        passwordTextfieldView.bottomAnchor.constraint(equalTo: self.topView.bottomAnchor).isActive = true
        //
        passwordTitleLbl.leadingAnchor.constraint(equalTo: self.topTextfieldView.leadingAnchor, constant: 20).isActive = true
        passwordTitleLbl.topAnchor.constraint(equalTo: self.topTextfieldView.topAnchor, constant: 20).isActive = true
        passwordTitleLbl.trailingAnchor.constraint(equalTo: self.topTextfieldView.trailingAnchor, constant: -20).isActive = true
        //
        passwordTextfield.leadingAnchor.constraint(equalTo: self.topTextfieldView.leadingAnchor, constant: 20).isActive = true
        passwordTextfield.trailingAnchor.constraint(equalTo: self.topTextfieldView.trailingAnchor, constant: -20).isActive = true
        passwordTextfield.topAnchor.constraint(equalTo: self.emalTitleLbl.bottomAnchor, constant: 15).isActive = true
        passwordTextfield.heightAnchor.constraint(equalToConstant: 50).isActive = true
        //
        passwordRequirmentTitle.leadingAnchor.constraint(equalTo: self.passwordTextfieldView.leadingAnchor, constant: 20).isActive = true
        passwordRequirmentTitle.trailingAnchor.constraint(equalTo: self.passwordTextfieldView.trailingAnchor, constant: -20).isActive = true
        passwordRequirmentTitle.topAnchor.constraint(equalTo: self.passwordTextfield.bottomAnchor, constant: 20).isActive = true
        //
        passwordLowerCaseTitle.leadingAnchor.constraint(equalTo: self.passwordTextfieldView.leadingAnchor, constant: 25).isActive = true
        passwordLowerCaseTitle.rightAnchor.constraint(equalTo: self.passwordTextfieldView.centerXAnchor, constant: -20).isActive = true
        passwordLowerCaseTitle.topAnchor.constraint(equalTo: self.passwordRequirmentTitle.bottomAnchor, constant: 20).isActive = true
        //
        passwordNumberTitle.leftAnchor.constraint(equalTo: self.passwordTextfieldView.centerXAnchor, constant: 20).isActive = true
        passwordNumberTitle.trailingAnchor.constraint(equalTo: self.passwordTextfieldView.trailingAnchor, constant: -20).isActive = true
        passwordNumberTitle.topAnchor.constraint(equalTo: self.passwordRequirmentTitle.bottomAnchor, constant: 20).isActive = true
        //
        passwordHigherCaseTitle.leadingAnchor.constraint(equalTo: self.passwordTextfieldView.leadingAnchor, constant: 25).isActive = true
        passwordHigherCaseTitle.rightAnchor.constraint(equalTo: self.passwordTextfieldView.centerXAnchor, constant: -20).isActive = true
        passwordHigherCaseTitle.topAnchor.constraint(equalTo: self.passwordLowerCaseTitle.bottomAnchor, constant: 15).isActive = true
        //
        passwordCharacterTitle.leftAnchor.constraint(equalTo: self.passwordTextfieldView.centerXAnchor, constant: 20).isActive = true
        passwordCharacterTitle.trailingAnchor.constraint(equalTo: self.passwordTextfieldView.trailingAnchor, constant: -20).isActive = true
        passwordCharacterTitle.topAnchor.constraint(equalTo: self.passwordNumberTitle.bottomAnchor, constant: 15).isActive = true
        //
        countryTextfieldView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        countryTextfieldView.topAnchor.constraint(equalTo: self.titleLbl.bottomAnchor, constant: 20).isActive = true
        countryTextfieldView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        countryTextfieldView.heightAnchor.constraint(equalToConstant: textfieldViewHeight).isActive = true
        //
        countryTitleLbl.leadingAnchor.constraint(equalTo: self.topTextfieldView.leadingAnchor, constant: 20).isActive = true
        countryTitleLbl.topAnchor.constraint(equalTo: self.topTextfieldView.topAnchor, constant: 20).isActive = true
        countryTitleLbl.trailingAnchor.constraint(equalTo: self.topTextfieldView.trailingAnchor, constant: -20).isActive = true
        //
        countryTextfield.leadingAnchor.constraint(equalTo: self.topTextfieldView.leadingAnchor, constant: 20).isActive = true
        countryTextfield.trailingAnchor.constraint(equalTo: self.topTextfieldView.trailingAnchor, constant: -20).isActive = true
        countryTextfield.topAnchor.constraint(equalTo: self.emalTitleLbl.bottomAnchor, constant: 15).isActive = true
        countryTextfield.heightAnchor.constraint(equalToConstant: 50).isActive = true
        //
        progressTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        progressTableView.topAnchor.constraint(equalTo: self.topView.bottomAnchor, constant: 50).isActive = true
        progressTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        progressTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        //
        registerButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        registerButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        registerButton.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -40).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: registerButtonHeight).isActive = true
        //
        rewardImageView.topAnchor.constraint(equalTo: self.topView.topAnchor, constant: 100).isActive = true
        rewardImageView.centerXAnchor.constraint(equalTo: self.topView.centerXAnchor).isActive = true
        rewardImageView.widthAnchor.constraint(equalToConstant: 280).isActive = true
        rewardImageView.heightAnchor.constraint(equalToConstant: 280).isActive = true
        //
        rewardSuccessLbl.topAnchor.constraint(equalTo: self.rewardImageView.bottomAnchor, constant: 40).isActive = true
        rewardSuccessLbl.centerXAnchor.constraint(equalTo: self.topView.centerXAnchor).isActive = true
        rewardSuccessLbl.leadingAnchor.constraint(equalTo: self.topView.leadingAnchor, constant: 50).isActive = true
        rewardSuccessLbl.trailingAnchor.constraint(equalTo: self.topView.trailingAnchor, constant: -50).isActive = true
    }
    
    func setupToolBar(){
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = .white
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(CountryDoneButton))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(CountryCancelButton))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        countryTextfield.inputAccessoryView = toolBar
    }
    
    func populateTextfields(){
        guard let type = currentTextfield else {return}
        switch type{
        case .Email:
            self.populateEmailTextfield()
        case .Password:
            self.populatePasswordTextfield()
        case .Country:
            self.populateCountryTextfield()
        default:
            break
        }
    }
    
    func populateEmailTextfield(){
        self.passwordTextfieldView.alpha = 0
        self.countryTextfieldView.alpha = 0
        self.topTextfieldView.alpha = 1
        self.rewardSuccessLbl.alpha = 0
        self.progressTableView.alpha = 1
        self.rewardImageView.alpha = 0
        self.rewardSuccessLbl.alpha = 0
        self.topviewMultiplier = 3
        self.animateTopViewHeight()
    }
    
    func populatePasswordTextfield(){
        self.passwordTextfieldView.alpha = 1
        self.countryTextfieldView.alpha = 0
        self.topTextfieldView.alpha = 0
        self.rewardSuccessLbl.alpha = 0
        self.progressTableView.alpha = 1
        self.rewardImageView.alpha = 0
        self.rewardSuccessLbl.alpha = 0
        self.topviewMultiplier = 2.2
        self.animateTopViewHeight()
    }
    
    func populateCountryTextfield(){
        self.passwordTextfieldView.alpha = 0
        self.countryTextfieldView.alpha = 1
        self.topTextfieldView.alpha = 0
        self.rewardSuccessLbl.alpha = 0
        self.progressTableView.alpha = 1
        self.rewardImageView.alpha = 0
        self.rewardSuccessLbl.alpha = 0
        self.topviewMultiplier = 3
        self.animateTopViewHeight()
    }
    
    func populateRewardiew(){
        self.passwordTextfieldView.alpha = 0
        self.countryTextfieldView.alpha = 0
        self.topTextfieldView.alpha = 0
        self.titleLbl.alpha = 0
        self.rewardSuccessLbl.alpha = 1
        self.topviewMultiplier = 1.2
        self.animateTopViewHeight()
        self.animateTopView()
        self.progressTableView.alpha = 0
    }

    func AnimateCelebration(){
        DispatchQueue.main.async {
            self.emiterLayer.emitterPosition = .init(x: self.frame.width/2, y: -100)
            self.emiterLayer.emitterShape = .line
            self.emiterLayer.emitterSize = .init(width:self.frame.width, height: 2.0)
            self.emiterLayer.emitterCells = emitterAnimationCell.shared.ConfettiEmitterCell(self.coffetiImages, 400)
            self.topView.layer.addSublayer(self.emiterLayer)
        }
        
    }
    
    @objc func sendSelectedTextfielddata(_ sender: UIButton){
        guard let type = currentTextfield else {return }
        if type == .Email{
            self.selectedTextfieldData?.textfieldData(0)
        }else if type == .Password{
            self.selectedTextfieldData?.textfieldData(1)
        }else if type == .Country{
            self.selectedTextfieldData?.textfieldData(2)
        }
    }
    
    func animateTopViewHeight(){
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
            self.topViewheightConstraint.constant = self.topViewHeight/self.topviewMultiplier
            self.layoutIfNeeded()
        } completion: { _ in
            print("Success")
        }

    }
    func animateTopView(){
        UIView.animate(withDuration: 0.4, delay: 0.5, options: .curveEaseInOut) {
            self.rewardImageView.alpha = 1
            self.rewardSuccessLbl.alpha = 1
            self.layoutIfNeeded()
        } completion: { _ in
            self.AnimateCelebration()
            self.registerButton.setTitle("Continue Shopping", for: .normal)
        }

    }
    
    @objc func CountryDoneButton(){
        countryTextfield.resignFirstResponder()
        self.endEditing(true)
    }
    
    @objc func CountryCancelButton(){
        countryTextfield.resignFirstResponder()
        self.endEditing(true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


