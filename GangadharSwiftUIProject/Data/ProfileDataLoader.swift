//
//  ProfileDataLoader.swift
//  GangadharSwiftUIProject
//
//  Created by Gangadhar C on 10/17/23.
//

import Foundation

class ProfileDataLoader: ObservableObject{
    @Published var userProfile:UserData=UserData(id: 1, email: "String", firstName: "String", lastName: "String", avatar: "https://reqres.in/img/faces/7-image.jpg")
    func getUsers() async throws{
            guard let userUrl = URL(string:"\(WebContants.baseURL)\(WebContants.user)") else{
                fatalError()
            }
            let userRequest = URLRequest(url: userUrl)
            let (data, response) = try await URLSession.shared.data(for: userRequest)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else{
                fatalError()
            }
            
        Task{ @MainActor in
            let allUsersData = try?  JSONDecoder().decode(SingleUser.self, from: data)
            guard let usersData = allUsersData else{
                fatalError()
            }
            userProfile = usersData.data
        }
    }
}
