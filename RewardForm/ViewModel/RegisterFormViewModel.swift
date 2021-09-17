//
//  RegisterFormViewModel.swift
//  RewardForm
//
//  Created by Nikhil Desai on 29/08/21.
//

import Foundation
import Combine

class RegisterFormViewModel{
    @Published  var progressData : [ProgressData] = [.init(title: "Enter Your Email", type: .InProgress, image: nil),.init(title: "Set Password", type: .UpComing, image: nil),.init(title: "Select Country", type: .UpComing, image: nil),.init(title: "Get 1500/- Coupon", type: .UpComing, image: "medal")]
    @Published var emailAddress : String?
    @Published var password : String?
    @Published var country : String?
    
     var isValidEmail:AnyPublisher<String?,Never>{
        return $emailAddress
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .map{ email in
                guard let email = email else {return nil}
                return email.count > 5 ? email : nil
            }
            .eraseToAnyPublisher()
    }
    
    var charValidPassword:AnyPublisher<String?,Never>{
        return $password
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .map{ pass in
                guard let passChar = pass else {return nil}
                return passChar.count >= 8 &&  passChar.count <= 16 ? passChar : nil
            }
            .eraseToAnyPublisher()
    }
    
    var numberValidPassword:AnyPublisher<String?,Never>{
        return $password
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .map{ pass in
                guard let passChar = pass else {return nil}
                let numbersRange = passChar.rangeOfCharacter(from: .decimalDigits)
                let hasNumbers = numbersRange != nil
                return hasNumbers ? passChar : nil
            }
            .eraseToAnyPublisher()
    }
    
    var lowerCaseValidPassword:AnyPublisher<String?,Never>{
        return $password
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .map{ pass in
                guard let passChar = pass else {return nil}
                return passChar.validateLowercase() ? passChar : nil
            }
            .eraseToAnyPublisher()
    }
    
    var upperCaseValidPassword:AnyPublisher<String?,Never>{
        return $password
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .map{ pass in
                guard let passChar = pass else {return nil}
                return passChar.validateUppercase() ? passChar : nil
            }
            .eraseToAnyPublisher()
    }
    
    var isValidPassword:AnyPublisher<Bool,Never>{
        return Publishers.CombineLatest4(charValidPassword,numberValidPassword,lowerCaseValidPassword,upperCaseValidPassword)
            .map{ char,num,lower,upper in
                return char != nil && num != nil  && lower != nil  && upper != nil
            }
            .eraseToAnyPublisher()
    }
    
    var isValidCountry:AnyPublisher<String?,Never>{
       return $country
           .debounce(for: 0.5, scheduler: RunLoop.main)
           .map{ countrydata in
               guard let countryData = countrydata else {return nil}
               return countryData
           }
           .eraseToAnyPublisher()
   }
    
    func setTextfieldType() -> textfieldType?{
        let inProgressData = self.progressData.filter({$0.type == .InProgress})
        if inProgressData.count != 0 {
            if inProgressData[0].title == "Enter Your Email"{
                return .Email
            }else if inProgressData[0].title == "Set Password"{
                return .Password
            }else if inProgressData[0].title == "Select Country"{
                return .Country
            }else if inProgressData[0].title == "Get 1500/- Coupon"{
                return .Reward
            }
            return nil
        }else{
            let completedData = self.progressData.filter({$0.type == .Completed})
            if completedData.count >= 3{
                return .Reward
            }
        }
        return nil
    }
    
}
