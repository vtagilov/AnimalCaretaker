//
//  MainTableVC.swift
//  AnimalCaretaker
//
//  Created by Владимир on 11.09.2023.
//

import UIKit

class MainTableVC: UITableViewController {

    var animalModels = [AnimalCellModel]()
    let networkManager = NetworkManager(.dogs)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(AnimalCell.self, forCellReuseIdentifier: "AnimalCell")
        networkManager.delegate = self
        networkManager.loadCell()
    }

    
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animalModels.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "AnimalCell", for: indexPath) as? AnimalCell {
            cell.configureCell(animalModels[indexPath.row])
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnimalCell", for: indexPath)
        return cell
    }

    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let image = animalModels[indexPath.row].image
        let aspectRatio = image.size.width / image.size.height
        let cellHeight = tableView.bounds.width / aspectRatio + 40
        return cellHeight
    }
    

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row > 2 {
            if tableView.numberOfRows(inSection: 0) <= indexPath.row + 1 {
                    self.networkManager.loadCell()
                
            }
        }
    }
    
}




extension MainTableVC: NetworkProtocol {
    
    func addAnimalModel(_ animalModel: AnimalCellModel) {
        animalModels.append(animalModel)
        self.tableView.reloadData()
        print(animalModels.count)
    }
    
    func loadError(_ error: Error) {
        print("MainTableVC loadError: ", error)
        if error is CustomError {
            let error = error as! CustomError
            print(error.localizedDescription)
        }
        networkManager.loadCell()
    }
    
}
