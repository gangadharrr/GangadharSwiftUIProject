//
//  UserDataLoader.swift
//  GangadharSwiftUIProject
//
//  Created by Gangadhar C on 10/17/23.
//

import Foundation
import SwiftUI
class UserDataLoader: ObservableObject{
    @Published var allUsers=[UserData]()
    func getUsers()  async throws {
            guard let userUrl = URL(string:"\(WebContants.baseURL)\(WebContants.users)") else{
                fatalError()
            }
            let userRequest = URLRequest(url: userUrl)
            let (data, response) = try await URLSession.shared.data(for: userRequest)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else{
                fatalError()
            }
            
        Task{ @MainActor in
            let allUsersData = try?  JSONDecoder().decode(AllUsers.self, from: data)
            guard let usersData = allUsersData else{
                fatalError()
            }
            allUsers = usersData.data
            
        }
    }
}
