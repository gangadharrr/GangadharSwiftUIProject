//
//  ApiModels.swift
//  GangadharSwiftUIProject
//
//  Created by Gangadhar C on 10/17/23.
//

import Foundation

struct LoginResponse:Codable{
    var token:String
}

struct LoginParams:Codable{
    var email:String
    var password:String
}
struct AllUsers:Decodable{
    var page: Int
    var per_page: Int
    var total: Int
    var total_pages: Int
    var data:[UserData]
}
struct SingleUser:Decodable{
    var data:UserData
}
struct UserData:Decodable{
    var id:Int
    var email:String
    var firstName:String
    var lastName:String
    var avatar:String
    
    var fullName:String{
        "\(firstName) \(lastName)"
    }
    var avatarURL:URL{
        URL(string: avatar)!
    }
    enum CodingKeys:String,CodingKey{
        case id
        case email
        case avatar
        case firstName="first_name"
        case lastName="last_name"
    }
}
