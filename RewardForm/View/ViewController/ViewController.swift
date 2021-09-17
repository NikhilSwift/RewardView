//
//  ViewController.swift
//  RewardForm
//
//  Created by Nikhil Desai on 27/08/21.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    var MainView : RewardFormView = {
        let view = RewardFormView()
        return view
    }()
    
    let viewModel = RegisterFormViewModel()
    var RegisterFormCancellable = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupObserever()
    }

    func setupView(){
        self.view = MainView
        MainView.progressTableView.backgroundColor = .clear
        MainView.progressTableView.separatorStyle = .none
        MainView.progressTableView.delegate = self
        MainView.progressTableView.dataSource = self
        MainView.progressTableView.register(ProgressViewTableViewCell.self, forCellReuseIdentifier: "ProgressViewTableViewCell")
        MainView.selectedTextfieldData = self
        MainView.emailTextfield.delegate = self
        MainView.passwordTextfield.delegate = self
        MainView.countryTextfield.delegate = self
        MainView.pickerView.delegate = self
        MainView.pickerView.dataSource = self
        MainView.registerButton.addTarget(self, action: #selector(RegisterUser(_:)), for: .touchUpInside)
    }

    func setupObserever(){
        viewModel.$progressData
            .receive(on: RunLoop.main)
            .sink { [weak self] data in
                guard let innserSelf = self, data.count != 0, let type = innserSelf.viewModel.setTextfieldType() else {return}
                innserSelf.MainView.currentTextfield = type
                innserSelf.MainView.progressTableView.reloadData()
            }
            .store(in: &RegisterFormCancellable)
        
        viewModel.charValidPassword
            .receive(on: RunLoop.main)
            .sink { pass in
                guard pass != nil else { self.MainView.passwordCharacterTitle.textColor = UIColor.white.withAlphaComponent(0.5); return}
                self.MainView.passwordCharacterTitle.textColor = .systemGreen
            }
            .store(in: &RegisterFormCancellable)
        
        viewModel.numberValidPassword
            .receive(on: RunLoop.main)
            .sink { pass in
                guard pass != nil else { self.MainView.passwordNumberTitle.textColor = UIColor.white.withAlphaComponent(0.5); return}
                self.MainView.passwordNumberTitle.textColor = .systemGreen
            }
            .store(in: &RegisterFormCancellable)
        
        viewModel.lowerCaseValidPassword
            .receive(on: RunLoop.main)
            .sink { pass in
                guard pass != nil else { self.MainView.passwordLowerCaseTitle.textColor = UIColor.white.withAlphaComponent(0.5); return}
                self.MainView.passwordLowerCaseTitle.textColor = .systemGreen
            }
            .store(in: &RegisterFormCancellable)
        
        viewModel.upperCaseValidPassword
            .receive(on: RunLoop.main)
            .sink { pass in
                guard pass != nil else { self.MainView.passwordHigherCaseTitle.textColor = UIColor.white.withAlphaComponent(0.5); return}
                self.MainView.passwordHigherCaseTitle.textColor = .systemGreen
            }
            .store(in: &RegisterFormCancellable)
    }
 
    @objc func RegisterUser(_ sender: UIButton){
        self.MainView.populateRewardiew()
    }
}


extension ViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.progressData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProgressViewTableViewCell", for: indexPath) as! ProgressViewTableViewCell
        let data = viewModel.progressData[indexPath.row]
        cell.progressVew.inProgress = data.type
        cell.data = data
        return cell
    }
   
    
}


extension ViewController: textfieldDataprotocol{
    func textfieldData(_ tag: Int) {
        print(tag,"tag")
        switch tag{
        case 0:
            self.viewModel.isValidEmail
                .receive(on: RunLoop.main)
                .sink { email in
                    guard let emaildata = email else {return}
                    self.MainView.emailTextfield.text = emaildata
                    self.PopulateEmail()
                }
                .store(in: &RegisterFormCancellable)
        case 1:
            self.viewModel.isValidPassword
                .receive(on: RunLoop.main)
                .sink { validpassword in
                    if validpassword{
                        self.MainView.passwordTextfield.text = self.viewModel.password ?? ""
                        self.PopulatePassword()
                    }
                }
                .store(in: &RegisterFormCancellable)
        case 2:
            self.viewModel.isValidCountry
                .receive(on: RunLoop.main)
                .sink { validCountry in
                    self.PopulateCountry()
                }
                .store(in: &RegisterFormCancellable)
            
        default:
            break
        }
    }
    
    func PopulateEmail(){
        self.viewModel.progressData[0].type = .Completed
        self.viewModel.progressData[1].type = .InProgress
        self.viewModel.progressData[2].type = .UpComing
    }
    
    func PopulatePassword(){
        self.viewModel.progressData[0].type = .Completed
        self.viewModel.progressData[1].type = .Completed
        self.viewModel.progressData[2].type = .InProgress
    }
    
    func PopulateCountry(){
        self.viewModel.progressData[0].type = .Completed
        self.viewModel.progressData[1].type = .Completed
        self.viewModel.progressData[2].type = .Completed
        self.viewModel.progressData[3].type = .InProgress
    }
}


extension ViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == 0{
            self.viewModel.emailAddress = textField.text
        }else if textField.tag == 1{
            self.viewModel.password = textField.text
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 0{
            self.viewModel.emailAddress = textField.text
        }else if textField.tag == 1{
            self.viewModel.password = textField.text
        }
        textField.resignFirstResponder()
        self.view.endEditing(true)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
         if textField.tag == 1{
            self.viewModel.password = textField.text
        }
        return true
    }
    
}


extension ViewController:UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
     }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Countries.shared.country_list.count
     }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Countries.shared.country_list[row]
      }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.MainView.countryTextfield.text = Countries.shared.country_list[row]
     }
}
