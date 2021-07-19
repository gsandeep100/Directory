//
//  Room.swift
//  Directory
//
//  Created by Sandeep on 18/07/2021.
//

import Foundation

typealias Rooms = [Room]

struct Room : Codable {

        let createdAt : String?
        let id : String?
        let isOccupied : Bool?
        let maxOccupancy : Int?
        let name : String?

        enum CodingKeys: String, CodingKey {
                case createdAt = "created_at"
                case id = "id"
                case isOccupied = "is_occupied"
                case maxOccupancy = "max_occupancy"
                case name = "name"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
                id = try values.decodeIfPresent(String.self, forKey: .id)
                isOccupied = try values.decodeIfPresent(Bool.self, forKey: .isOccupied)
                maxOccupancy = try values.decodeIfPresent(Int.self, forKey: .maxOccupancy)
                name = try values.decodeIfPresent(String.self, forKey: .name)
        }

}
