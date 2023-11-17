//
//  LaunchView.swift
//  GangadharSwiftUIProject
//
//  Created by Gangadhar C on 10/10/23.
//

import SwiftUI

struct LaunchView: View {
    @State var isSplash=true
    var body: some View {
        if(isSplash){
            ZStack{
                LinearGradient(colors: [Color(ColorConstants.voilet),Color(ColorConstants.secondaryColor)], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea(.all)
                VStack{
                    Spacer()
                    Image(ImageConstants.AppLogo).resizable().aspectRatio(contentMode: .fit).frame(width:300,height: 300)
                    Spacer()
                    Text(AppInfo.AppVersion).foregroundColor(.white)
                }
            }.onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now()+1, execute:{
                    withAnimation{
                        self.isSplash=false
                    }
                })
            }
        }
        else{
            if(UserDefaults.standard.bool(forKey: AppKeys.Token)){
                UserHomeView()
                
            }else{
                LoginView()
            }
            
        }
        
    }
}

#Preview {
    LaunchView()
}
