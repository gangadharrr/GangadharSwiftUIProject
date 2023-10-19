//
//  StringExtension.swift
//  GangadharSwiftUIProject
//
//  Created by Gangadhar C on 10/16/23.
//

import Foundation
extension String{
    var emailRegEx:String { "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    }
    var passwordRegEx:String { "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[#$@!%&*?])[A-Za-z0-9#$@!%&*?]{8,30}$"
    }
    func isValidPassword()->Bool{
        let passwordPred = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordPred.evaluate(with: self)
    }
    func isValidEmail()->Bool{
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    var localized:String{
        NSLocalizedString(self, comment: "NA")
    }
}
