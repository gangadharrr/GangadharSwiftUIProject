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
    @State var isBusy:Bool=false
    @State var EmailError:WarningMessage=WarningMessage(title: Titles.EmailErrorTitle, message: Messages.EmailErrorMessage, dismissText: "Try Again")
    @State var PasswordError:WarningMessage=WarningMessage(title: Titles.PasswordErrorTitle, message: Messages.PasswordErrorMessage, dismissText: "Try Again")
    @State var ErrorMessage:WarningMessage=WarningMessage(title:Titles.NetworkErrorTitle , message: Messages.NetworkErrorMessages, dismissText: "Try Again")
    @State var loginFailed=false
    @State var UserDisplayScreen:Bool=false
    var body: some View {
        // MainView ->
        NavigationStack{
            if(isBusy){
                BusyView(message: Messages.Authenticating)
            }
            else{
                ZStack{
                    VStack{
                        Spacer()
                        Image("AppLogo").resizable().aspectRatio(contentMode: .fit).frame(width:200,height: 200)
                        if(loginFailed){
                            Text(Messages.LoginFailed).foregroundColor(.red)
                                .onAppear{
                                    DispatchQueue.main.asyncAfter(deadline: .now()+3, execute:{
                                        withAnimation{
                                            loginFailed=false
                                        }
                                    })
                                }
                        }
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
                        .navigationDestination(isPresented: $ShowRegisterView, destination:{
                            RegistrationView()
                        })
                        .navigationDestination(isPresented: $UserDisplayScreen, destination:{ UserHomeView()})
                        Button {
                            isBusy=true
                            tryLoginWithProtocol()
                            
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
    }
    private func tryLoginWithProtocol(){
        if(!network.isConnected){
            ErrorMessage.showWarning = !network.isConnected
            return
        }
        guard let loginURL = URL(string: "\(WebContants.baseURL)\(WebContants.login)")else{fatalError()}
        var loginRequest = URLRequest(url: loginURL)
        loginRequest.httpMethod="POST"
        loginRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let params = LoginParams(email: InputEmail, password: InputPassword)
        loginRequest.httpBody = try? JSONEncoder().encode(params)
        URLSession.shared.dataTask(with: loginRequest){ Data, response, error in
            isBusy=false
            guard let data=Data, error==nil else{
                print(error?.localizedDescription ?? "ERROR API")
                return
            }
            if let httpStatus=response as? HTTPURLResponse , httpStatus.statusCode == 200{
                DispatchQueue.main.async {
                    self.extractData(data)
                    UserDisplayScreen=true
                }
            }
            else{
                loginFailed=true
            }
        }.resume()
        
        
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
                print(error?.localizedDescription ?? "ERROR API")
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
        //        let responseData = try? JSONSerialization.jsonObject(with: data) as? Dictionary<String,String>
        let responseData = try? JSONDecoder().decode(LoginResponse.self, from: data)
        //        print(responseData!["token"] ?? "No Token")
        
        // in Preferences user details data will be stored
        // NSHomeDirectory will print path of local storage at which app is stored
        if let token = responseData?.token{
            UserDefaults.standard.setValue(token, forKey: AppKeys.Token)
            print(NSHomeDirectory())
        }
        
        print(responseData?.token ?? "No Token")
        
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
