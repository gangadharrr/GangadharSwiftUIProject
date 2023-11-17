//
//  ProfileView.swift
//  GangadharSwiftUIProject
//
//  Created by Gangadhar C on 10/17/23.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var profileDataLoader = ProfileDataLoader()
    var user:UserData{
        profileDataLoader.userProfile
    }
    @State var isLoading:Bool=true
    var body: some View {
        if(isLoading){
            BusyView(message: Messages.FetchingUsers)
                .onAppear{
                    Task{
                        try await profileDataLoader.getUsers(1)
                        isLoading=false
                    }
                }
        }
        else{
            NavigationView{
                VStack{
                    Text(LabelConstants.UsersDetails).font(.title).bold()
                    AsyncImage(url: user.avatarURL,scale: 0.5){image in image.scaledToFit().clipShape(Circle())
                        
                    }placeholder: {
                        ProgressView().frame(width:250,height: 250)
                    }
                    Text(user.fullName).font(.title2).bold()
                    Link(user.email, destination: URL(string: "mailto://\(user.email)")!)
                    Spacer()
                    Text(LabelConstants.ContactDetails).bold()
                    Link("+91 8919768667", destination: URL(string: "tel://8919768667")!)
                    Button("Support"){
                        let numberUrl = URL(string: "https://www.github.com")!
                        if UIApplication.shared.canOpenURL(numberUrl) {
                            UIApplication.shared.open(numberUrl)
                        }
                    }

                }
            }
        }
        
    }
}

#Preview {
    ProfileView()
}
