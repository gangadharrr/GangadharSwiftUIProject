//
//  UserDetailsView.swift
//  GangadharSwiftUIProject
//
//  Created by Gangadhar C on 10/17/23.
//

import SwiftUI

struct UserDetailsView: View {
    var user:UserData
    @State var isLoading:Bool=true
    var body: some View {
        if(isLoading){
            BusyView(message: Messages.FetchingUsers).onAppear{
                isLoading=false
            }
        }
        else{
            NavigationView{
                VStack{
                    Text(LabelConstants.UsersDetails).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).bold()
                    AsyncImage(url: user.avatarURL,scale: 0.5){ image in
                        image.resizable()
                            .scaledToFit().clipShape(Circle())
                            .frame(width: 200, height: 200)
                    }placeholder:{
                        ProgressView().dynamicTypeSize(.xxxLarge)
                    }
                    Text(user.fullName).font(.title2).bold()
                    Text(user.email).font(.title3).foregroundColor(.accentColor)
                    Spacer()
                }
            }
        }
     
        
        
    }
}

#Preview {
    UserDetailsView(user:  UserData(id: 1, email: "email", firstName: "Michel", lastName: "Lawson", avatar: "https://reqres.in/img/faces/7-image.jpg"))
}
