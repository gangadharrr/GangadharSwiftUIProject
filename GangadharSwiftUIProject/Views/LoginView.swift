//
//  LoginView.swift
//  GangadharSwiftUIProject
//
//  Created by Gangadhar C on 10/10/23.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var network = NetworkMonitor()
    @State var InputEmail:String=""
    @State var InputPassword:String=""
    @State var ShowPassword:Bool=false
    @State var ShowRegisterView:Bool=false
    @State var EmailError:WarningMessage=WarningMessage(title: Titles.EmailErrorTitle, message: Messages.EmailErrorMessage, dismissText: "Try Again")
    @State var PasswordError:WarningMessage=WarningMessage(title: Titles.PasswordErrorTitle, message: Messages.PasswordErrorMessage, dismissText: "Try Again")
    @State var ErrorMessage:WarningMessage=WarningMessage(title:Titles.NetworkErrorTitle , message: Messages.NetworkErrorMessages, dismissText: "Try Again")
    var body: some View {
        // MainView ->
        NavigationStack{
            ZStack{
                VStack{
                    Spacer()
                    Image("AppLogo").resizable().aspectRatio(contentMode: .fit).frame(width:200,height: 200)
                    InputFieldWithLogo(InputField: $InputEmail,
                                       PlaceHolder: "Enter Email",
                                       ImageName: "person.fill",
                                       warningMessage:$EmailError
                    ).padding(.vertical,5).onSubmit() {
                        self.EmailError.showWarning = !InputEmail.isValidEmail()
                        print(EmailError)
                    }
                    
                    InputFieldWithLogo(InputField: $InputPassword,
                                       PlaceHolder: "Enter Password",
                                       ImageName: "lock.fill",Password: true,
                                       warningMessage:$PasswordError , ShowPassword: ShowPassword
                    ).padding(.vertical, Constants.textfieldSpacing).onSubmit {
                        self.PasswordError.showWarning = InputPassword.isEmpty
                        print(PasswordError)
                    }
                    NavigationLink(destination: RegistrationView(), isActive: $ShowRegisterView) {
                        
                    }
                    Button {
                        tryLogin()
                    }label:{
                        Text("Login").frame(maxWidth: .infinity)
                            .foregroundColor(.white).padding(8)
                            .font(.system(size: 21))
                            .background(Color("Primary"))
                            .cornerRadius(7.0)
                        
                    }.frame(maxWidth: 330)
                        .padding()
                        .alert(isPresented: $ErrorMessage.showWarning){
                            Alert(
                                title: Text(ErrorMessage.title),
                                message: Text(ErrorMessage.message),
                                dismissButton: .default(Text(ErrorMessage.dismissText), action: {
                                    ErrorMessage.showWarning=false
                                })
                            )
                        }
                    Spacer()
                    Spacer()
                    Spacer()
                    Button{
                        withAnimation{
                            ShowRegisterView.toggle()
                        }
                        
                    }label: {
                        Text("New User? Register").foregroundColor(Color("Primary"))
                    }
                }
            }.onTapGesture {
                self.endEditing()
            }
            .navigationBarTitle("Login").navigationBarTitleDisplayMode(.inline)
            
            
        }
    }
    private func tryLogin(){
        if(!network.isConnected){
            ErrorMessage.showWarning = !network.isConnected
            return
        }
        guard let loginURL = URL(string: "\(WebContants.baseURL)\(WebContants.login)")else{fatalError()}
        var loginRequest = URLRequest(url: loginURL)
        loginRequest.httpMethod="POST"
        loginRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let params = ["email":"\(InputEmail)","password":"\(InputPassword)"]
        loginRequest.httpBody = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        URLSession.shared.dataTask(with: loginRequest){ Data, response, error in
            guard let data=Data, error==nil else{
                print(error?.localizedDescription)
                return
            }
            if let httpStatus=response as? HTTPURLResponse , httpStatus.statusCode == 200{
                DispatchQueue.main.async {
                    self.extractData(data)
                }
            }
        }.resume()

        
        
    }
    private func extractData(_ data:Data){
        let responseData = try? JSONSerialization.jsonObject(with: data) as? Dictionary<String,String>
        print(responseData!["token"])
    }
}

#Preview {
    LoginView()
}


fileprivate struct Constants {
    static var textfieldSpacing: CGFloat {
        5.0
    }
}
