//
//  RegistrationView.swift
//  GangadharSwiftUIProject
//
//  Created by Gangadhar C on 10/10/23.
//

import SwiftUI

struct RegistrationView: View {
    @State var InputName:String=StringConstants.EmptyString
    @State var InputEmail:String=StringConstants.EmptyString
    @State var InputPassword:String=StringConstants.EmptyString
    @State var ReTypePassword:String=StringConstants.EmptyString
    @State var ShowPassword:Bool=false
    @State var EmailError:WarningMessage=WarningMessage(title: Titles.EmailErrorTitle, message: Messages.EmailErrorMessage, dismissText: Messages.TryAgain)
    @State var PasswordError:WarningMessage=WarningMessage(title: Titles.PasswordErrorTitle, message: Messages.PasswordErrorMessage, dismissText: Messages.TryAgain)
    @State var ReTypePasswordError:WarningMessage=WarningMessage(title: Titles.PasswordErrorTitle, message: Messages.PasswordErrorMessage, dismissText: Messages.TryAgain)
    @State var ErrorMessage:WarningMessage=WarningMessage(title: StringConstants.EmptyString, message: StringConstants.EmptyString, dismissText: StringConstants.EmptyString)
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack{
            VStack{
                Spacer()
                Image(ImageConstants.AppLogo).resizable().aspectRatio(contentMode: .fit).frame(width:200,height: 200)
                InputFieldWithLogo(InputField: $InputName, PlaceHolder: PlaceholdersConstants.Username, ImageName: ImageConstants.SYSPersonFill,warningMessage: .constant(WarningMessage(title: "", message: "", dismissText: ""))).padding(.vertical,5)
                InputFieldWithLogo(InputField: $InputEmail, PlaceHolder: PlaceholdersConstants.Email, ImageName: ImageConstants.SYSEnvelopeFill,warningMessage:$EmailError).padding(.vertical,5).onSubmit {
                    self.EmailError.showWarning = !InputEmail.isValidEmail()
                }
                
                InputFieldWithLogo(InputField: $InputPassword, PlaceHolder: PlaceholdersConstants.Password, ImageName: ImageConstants.SYSLockFill,Password: true,warningMessage: $PasswordError, ShowEye:false).padding(.vertical,5).onSubmit {
                    self.PasswordError.showWarning = !InputPassword.isValidPassword()
                }
                InputFieldWithLogo(InputField: $ReTypePassword, PlaceHolder: PlaceholdersConstants.reEnterPassword, ImageName: ImageConstants.SYSLockFill,Password: true,warningMessage: $ReTypePasswordError, ShowPassword: ShowPassword).padding(.vertical,5).onSubmit {
                    self.ReTypePasswordError.showWarning =  !(InputPassword==ReTypePassword)
                }
                
                Button {
                    
                }label:{
                    Text(LabelConstants.Register).frame(maxWidth: .infinity)
                        .foregroundColor(.white).padding(8)
                        .font(.system(size: 21))
                        .background(Color(ColorConstants.primaryColor))
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
                    Text(LabelConstants.RegisterAlready).foregroundColor(Color(ColorConstants.primaryColor))
                }
                
            }.navigationBarTitle(LabelConstants.Register)
            .navigationBarTitleDisplayMode(.inline)
        }.onTapGesture {
            self.endEditing()
        }
    }
}

#Preview {
    RegistrationView()
}
