//
//  PeoplesViewModel.swift
//  Directory
//
//  Created by Sandeep on 18/07/2021.
//

import Foundation
class PeoplesViewModel: NSObject {
    private var peopleService: PeoplesServiceProtocol
    
    var reloadTableView: (() -> Void)?
    
    var peoples = Peoples()
    
    var peopleCellViewModels = [PeopleCellViewModel]() {
        didSet {
            reloadTableView?()
        }
    }

    init(peopleService: PeoplesServiceProtocol = Service()) {
        self.peopleService = peopleService
    }
    
    func getPeoples() {
        peopleService.getPeoples { success, model, error in
            if success, let peoples = model {
                self.fetchData(peoples: peoples)
            } else {
                print(error!)
            }
        }
    }
    
    func fetchData(peoples: Peoples) {
        self.peoples = peoples // Cache
        var vms = [PeopleCellViewModel]()
        for people in peoples {
            vms.append(createCellModel(people: people))
        }
        peopleCellViewModels = vms
    }
    
    func createCellModel(people: People) -> PeopleCellViewModel {
        
        let id = people.id
        let phone = people.phone
        let name = people.firstName! + " " + people.lastName!
        let email = people.email
        let createdAt = Utility.formatDate(input: people.createdAt!)
        let jobTitle = people.jobTitle
        let favouriteColor = people.favouriteColor
        let avatar = people.avatar
        let latitude = people.latitude!
        let longitude = people.longitude!;


        return PeopleCellViewModel(avatar: avatar!, createdAt: createdAt, email: email!, favouriteColor: favouriteColor!, name: name, id:id!, jobTitle:jobTitle!, latitude:latitude,longitude:longitude,phone:phone!)
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> PeopleCellViewModel {
        return peopleCellViewModels[indexPath.row]
    }
}
