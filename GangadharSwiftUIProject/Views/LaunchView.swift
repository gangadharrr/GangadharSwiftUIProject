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
                LinearGradient(colors: [Color("Primary"),Color("Secondary")], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea(.all)
                VStack{
                    Spacer()
                    Image("AppLogo").resizable().aspectRatio(contentMode: .fit).frame(width:300,height: 300)
                    Spacer()
                    Text("Version 0.0.1").foregroundColor(.white)
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
            LoginView()
        }
        
    }
}

#Preview {
    LaunchView()
}
