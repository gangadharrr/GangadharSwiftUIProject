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
    
    var body: some View {
        NavigationStack{
            VStack{
                Text("User Details").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).bold()
                AsyncImage(url: user.avatarURL,scale: 0.5).scaledToFit().clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                Text(user.fullName).font(.title2).bold()
                Text(user.email).font(.title3).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                Spacer()
            }
        }.onAppear{
            Task{
                try await profileDataLoader.getUsers()
            }
        }
        
    }
}

#Preview {
    ProfileView()
}
