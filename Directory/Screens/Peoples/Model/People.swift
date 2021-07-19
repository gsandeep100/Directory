//
//  People.swift
//  Directory
//
//  Created by Sandeep on 18/07/2021.
//


import Foundation

typealias Peoples = [People]

struct People : Codable {
        let avatar : String?
        let createdAt : String?
        let email : String?
        let favouriteColor : String?
        let firstName : String?
        let id : String?
        let jobTitle : String?
        let lastName : String?
        let latitude : Double?
        let longitude : Double?
        let phone : String?

        enum CodingKeys: String, CodingKey {
                case avatar = "avatar"
                case createdAt = "createdAt"
                case email = "email"
                case favouriteColor = "favouriteColor"
                case firstName = "firstName"
                case id = "id"
                case jobTitle = "jobTitle"
                case lastName = "lastName"
                case latitude = "latitude"
                case longitude = "longitude"
                case phone = "phone"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                avatar = try values.decodeIfPresent(String.self, forKey: .avatar)
            createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)!
                email = try values.decodeIfPresent(String.self, forKey: .email)
                favouriteColor = try values.decodeIfPresent(String.self, forKey: .favouriteColor)
                firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
                id = try values.decodeIfPresent(String.self, forKey: .id)
                jobTitle = try values.decodeIfPresent(String.self, forKey: .jobTitle)
                lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
                latitude = try values.decodeIfPresent(Double.self, forKey: .latitude)
                longitude = try values.decodeIfPresent(Double.self, forKey: .longitude)
                phone = try values.decodeIfPresent(String.self, forKey: .phone)
        }

}
