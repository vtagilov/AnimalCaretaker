//
//  ProfileVC.swift
//  AnimalCaretaker
//
//  Created by Владимир on 07.09.2023.
//

import UIKit

class ProfileVC: UIViewController {

    var animalLikedModels = [AnimalCellModel]()
    var animalPostedModels = [AnimalCellModel]()
    
    let likeManager = LikeManager()
    
    let profileInfo = ProfileInfoView()
    
    let tableView = UITableView()
    let segmentControl = UISegmentedControl()
    
    var tapRecognizer = UITapGestureRecognizer()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        profileInfo.delegate = self
        configureUI()
        configureConstrainst()
        setTapRecognizer()
        tableViewRefreshControl()
    }
    

    
    private func configureUI() {
        segmentControl.makeProfileControl()
        segmentControl.addTarget(self, action: #selector(reloadTableViewData), for: .valueChanged)
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(tableViewRefreshControl), for: .valueChanged)
        tableView.refreshControl = refreshControl
        tableView.register(AnimalCell.self, forCellReuseIdentifier: "AnimalCell")

        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    
    private func configureConstrainst() {
        self.view.addSubview(profileInfo)
        self.view.addSubview(segmentControl)
        self.view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            profileInfo.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            profileInfo.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            profileInfo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileInfo.heightAnchor.constraint(equalToConstant: 125),
            
            segmentControl.topAnchor.constraint(equalTo: profileInfo.bottomAnchor, constant: 10),
            segmentControl.heightAnchor.constraint(equalToConstant: 40),
            segmentControl.leftAnchor.constraint(equalTo: view.leftAnchor),
            segmentControl.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            tableView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    
    @objc private func reloadTableViewData() {
        self.tableView.reloadData()
    }
    
    
    @objc private func tableViewRefreshControl() {
        self.animalLikedModels = self.likeManager.getModels()
        self.tableView.reloadData()
        self.profileInfo.updateCounterLabels()
        self.tableView.refreshControl?.endRefreshing()
    }
    
}


// MARK: - UITableView DataSource and Delegate
extension ProfileVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return [animalPostedModels.count, animalLikedModels.count][segmentControl.selectedSegmentIndex]
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let models = [animalPostedModels, animalLikedModels][segmentControl.selectedSegmentIndex]
        let model = models[animalLikedModels.count - indexPath.row - 1]
        let image = model.image
        let aspectRatio = image.size.width / image.size.height
        let cellHeight = tableView.bounds.width / aspectRatio + 40
        return cellHeight
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "AnimalCell", for: indexPath) as? AnimalCell {
            if segmentControl.selectedSegmentIndex == 1 {
                let animalModel = animalLikedModels[animalLikedModels.count - indexPath.row - 1]
                cell.configureCell(animalModel)
                cell.setLikeProperty(likeManager.isLiked(animalModel))
                cell.delegate = self
                return cell
            }
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnimalCell", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let animalModel = [animalPostedModels, animalLikedModels][segmentControl.selectedSegmentIndex][animalLikedModels.count - indexPath.row - 1]

        let oneImageVC = OneImageVC(indexPath.row, animalModel, likeManager.isLiked(animalModel))
        oneImageVC.delegate = self
        UIView.animate(withDuration: 0.2) {
            self.segmentControl.alpha = 0.0
            self.profileInfo.alpha = 0.0
            tableView.alpha = 0.0
        }
        navigationController?.isNavigationBarHidden = false
        navigationController?.pushViewController(oneImageVC, animated: true)
        
    }
    
}




// MARK: - Set Gesture Responder
extension ProfileVC {
    private func setTapRecognizer() {
        tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapRecognizerAction))
        view.addGestureRecognizer(tapRecognizer)
        tapRecognizer.isEnabled = false
    }
    
    @objc private func tapRecognizerAction() {
        profileInfo.nickTextField.resignFirstResponder()
    }
}



// MARK: - AnimalCellDelegate
extension ProfileVC: AnimalCellDelegate {
    func likeImageAction(_ model: AnimalCellModel) {
        if likeManager.isLiked(model) {
            likeManager.removeLike(model)
        } else {
            likeManager.addLike(model)
        }
    }
}



// MARK: - ProfileInfoViewDelegate
extension ProfileVC: ProfileInfoViewDelegate {
    func presentTextFieldAlert(_ alert: UIAlertController) {
        present(alert, animated: true)
    }
    
    func turnTapRecognizer() {
        tapRecognizer.isEnabled = !tapRecognizer.isEnabled
    }
}



// MARK: - CloseImageDelegate
extension ProfileVC: CloseImageDelegate {
    func likeAction(_ sender: UIButton, _ model: AnimalCellModel, _ numberOfCell: Int) {
        likeImageAction(model)
        let cell = tableView.cellForRow(at: IndexPath(row: numberOfCell, section: 0)) as? AnimalCell
        cell?.setLikeProperty(!sender.isSelected)
    }
}
