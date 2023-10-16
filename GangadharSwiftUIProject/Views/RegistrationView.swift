//
//  RegistrationView.swift
//  GangadharSwiftUIProject
//
//  Created by Gangadhar C on 10/10/23.
//

import SwiftUI

struct RegistrationView: View {
    @State var InputName:String=""
    @State var InputEmail:String=""
    @State var InputPassword:String=""
    @State var ReTypePassword:String=""
    @State var ShowPassword:Bool=false
    @State var EmailError:WarningMessage=WarningMessage(title: Titles.EmailErrorTitle, message: Messages.EmailErrorMessage, dismissText: "Try Again")
    @State var PasswordError:WarningMessage=WarningMessage(title: Titles.PasswordErrorTitle, message: Messages.PasswordErrorMessage, dismissText: "Try Again")
    @State var ReTypePasswordError:WarningMessage=WarningMessage(title: Titles.PasswordErrorTitle, message: Messages.PasswordErrorMessage, dismissText: "Try Again")
    @State var ErrorMessage:WarningMessage=WarningMessage(title: "", message: "", dismissText: "")
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack{
            VStack{
                Spacer()
                Image("AppLogo").resizable().aspectRatio(contentMode: .fit).frame(width:200,height: 200)
                InputFieldWithLogo(InputField: $InputName, PlaceHolder: "Enter Name", ImageName: "person.fill",warningMessage: .constant(WarningMessage(title: "", message: "", dismissText: ""))).padding(.vertical,5)
                InputFieldWithLogo(InputField: $InputEmail, PlaceHolder: "Enter Email", ImageName: "envelope.fill",warningMessage:$EmailError).padding(.vertical,5).onSubmit {
                    self.EmailError.showWarning = !InputEmail.isValidEmail()
                }
                
                InputFieldWithLogo(InputField: $InputPassword, PlaceHolder: "Enter Password", ImageName: "lock.fill",Password: true,warningMessage: $PasswordError, ShowEye:false).padding(.vertical,5).onSubmit {
                    self.PasswordError.showWarning = !InputPassword.isValidPassword()
                }
                InputFieldWithLogo(InputField: $ReTypePassword, PlaceHolder: "Re-Enter Password", ImageName: "lock.fill",Password: true,warningMessage: $ReTypePasswordError, ShowPassword: ShowPassword).padding(.vertical,5).onSubmit {
                    self.ReTypePasswordError.showWarning =  !(InputPassword==ReTypePassword)
                }
                
                Button {
                    
                }label:{
                    Text("Register").frame(maxWidth: .infinity)
                        .foregroundColor(.white).padding(8)
                        .font(.system(size: 21))
                        .background(Color("Primary"))
                        .cornerRadius(7.0)
                    
                }.frame(maxWidth: 330)
                    .padding()
                Spacer()
                Spacer()
                Button{
                    withAnimation{    
                        presentationMode.wrappedValue.dismiss()
                    }
                }label: {
                    Text("Registered Already? Login").foregroundColor(Color("Primary"))
                }
                
            }.navigationBarTitle("Register")
            .navigationBarTitleDisplayMode(.inline)
        }.onTapGesture {
            self.endEditing()
        }
    }
}

#Preview {
    RegistrationView()
}
