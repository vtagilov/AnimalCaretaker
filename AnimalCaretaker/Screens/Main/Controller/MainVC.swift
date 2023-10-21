//
//  MainVC.swift
//  AnimalCaretaker
//
//  Created by Владимир on 14.09.2023.
//

import UIKit

protocol AnimalCellDelegate {
    func likeImageAction(_ model: AnimalCellModel)
}


protocol NetworkProtocol {
    func addAnimalModel(_ animalModel: AnimalCellModel)
    func loadError(_ error: Error)
}



class MainVC: UIViewController {
    
    var animalModels = [AnimalCellModel]()
    
    let tableView = UITableView()
    
    let networkManager = NetworkManager(.dogs)
    let likeManager = LikeManager()
    
    var lastCell = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager.delegate = self
        networkManager.loadCell()
        configureUI()
        setConstraints()
    }
    
    
    
    private func configureUI() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(tableViewRefreshControl), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        tableView.register(AnimalCell.self, forCellReuseIdentifier: "AnimalCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
    }
    
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
    @objc private func tableViewRefreshControl() {
        animalModels = []
        tableView.reloadData()
        networkManager.loadCell()
        self.tableView.refreshControl?.endRefreshing()
    }

}



// MARK: - UITableView DataSource and Delegate
extension MainVC: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animalModels.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "AnimalCell", for: indexPath) as? AnimalCell {
            let animalModel = animalModels[indexPath.row]
            cell.configureCell(animalModel)
            cell.setLikeProperty(likeManager.isLiked(animalModel))
            cell.delegate = self
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnimalCell", for: indexPath)
        return cell
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let image = animalModels[indexPath.row].image
        let aspectRatio = image.size.width / image.size.height
        let cellHeight = tableView.bounds.width / aspectRatio + 40
        return cellHeight
    }
    

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row > 2 {
            if tableView.numberOfRows(inSection: 0) <= indexPath.row + 1 {
                    self.networkManager.loadCell()
            }
        }
        
        if lastCell < indexPath.row && indexPath.row > 3 {
            self.navigationController?.isNavigationBarHidden = true
        } else if lastCell > indexPath.row {
            self.navigationController?.isNavigationBarHidden = false
        }
        lastCell = indexPath.row
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let animalModel = animalModels[indexPath.row]
        let oneImageVC = OneImageVC(indexPath.row, animalModel, likeManager.isLiked(animalModel))
        oneImageVC.delegate = self
        UIView.animate(withDuration: 0.2) {
            tableView.alpha = 0.0
        }
        self.navigationController?.pushViewController(oneImageVC, animated: true)
    }
}


// MARK: - AnimalCellDelegate
extension MainVC: AnimalCellDelegate {
    func likeImageAction(_ model: AnimalCellModel) {
        if likeManager.isLiked(model) {
            likeManager.removeLike(model)
        } else {
            likeManager.addLike(model)
        }
    }
}


// MARK: - NetworkProtocol
extension MainVC: NetworkProtocol {
    
    func addAnimalModel(_ animalModel: AnimalCellModel) {
        animalModels.append(animalModel)
        self.tableView.reloadData()
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



//MARK: - CloseImageDelegate
extension MainVC: CloseImageDelegate {
    func likeAction(_ sender: UIButton, _ model: AnimalCellModel, _ numberOfCell: Int) {
        if sender.isSelected {
            likeManager.removeLike(model)
        } else {
            likeManager.addLike(model)
        }
        tableView.reloadData()
        
    }
}
