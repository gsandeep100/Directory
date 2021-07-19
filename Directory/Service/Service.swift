//
//  Service.swift
//  Directory
//
//  Created by Sandeep on 18/07/2021.
//

import Foundation


protocol PeoplesServiceProtocol {
    func getPeoples(completion: @escaping (_ success: Bool, _ results: Peoples?, _ error: String?) -> ())
}

protocol RoomsServiceProtocol {
    func getRooms(completion: @escaping (_ success: Bool, _ results: Rooms?, _ error: String?) -> ())
}

class Service: PeoplesServiceProtocol, RoomsServiceProtocol {
    private var sourcesURL:String =  "https://5f7c2c8400bd74001690a583.mockapi.io/api/v1/"
    func getPeoples(completion: @escaping (Bool, Peoples?, String?) -> ()) {
        sourcesURL+="people";
        HttpRequestHelper().GET(url: sourcesURL, params: ["": ""], httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(Peoples.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, "Error: Trying to parse Peoples to model")
                }
            } else {
                completion(false, nil, "Error: Peoples GET Request failed")
            }
        }
    }
    
    func getRooms(completion: @escaping (Bool, Rooms?, String?) -> ()) {
        sourcesURL+="rooms";

        HttpRequestHelper().GET(url: sourcesURL, params: ["": ""], httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(Rooms.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, "Error: Trying to parse Peoples to model")
                }
            } else {
                completion(false, nil, "Error: Peoples GET Request failed")
            }
        }
    }
}
