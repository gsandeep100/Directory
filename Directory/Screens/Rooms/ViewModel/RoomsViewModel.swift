//
//  RoomsViewModel.swift
//  Directory
//
//  Created by Sandeep on 18/07/2021.
//

import Foundation
import Foundation
class RoomsViewModel: NSObject {
    private var roomService: RoomsServiceProtocol
    
    var reloadTableView: (() -> Void)?
    
    var rooms = Rooms()
    
    var roomCellViewModels = [RoomCellViewModel]() {
        didSet {
            reloadTableView?()
        }
    }

    init(roomService: RoomsServiceProtocol = Service()) {
        self.roomService = roomService
    }
    
    func getRooms() {
        roomService.getRooms { success, model, error in
            if success, let rooms = model {
                self.fetchData(rooms: rooms)
            } else {
                print(error!)
            }
        }
    }
    
    func fetchData(rooms: Rooms) {
        self.rooms = rooms // Cache
        var vms = [RoomCellViewModel]()
        for room in rooms {
            vms.append(createCellModel(room: room))
        }
        roomCellViewModels = vms
    }
    
    func createCellModel(room: Room) -> RoomCellViewModel {
                
        let createdAt = Utility.formatDate(input: room.createdAt!)
        let id = room.id
        let isOccupied = room.isOccupied
        let maxOccupancy = room.maxOccupancy
        let name = room.name
    
        return RoomCellViewModel(createdAt: createdAt, id: id!, isOccupied: isOccupied!, maxOccupancy: maxOccupancy!, name: name!)
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> RoomCellViewModel {
        return roomCellViewModels[indexPath.row]
    }
}
