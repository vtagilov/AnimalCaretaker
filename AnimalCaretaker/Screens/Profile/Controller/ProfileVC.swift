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
    
    
    override func viewWillAppear(_ animated: Bool) {
        let models = likeManager.getModels()
        animalLikedModels = models
        profileInfo.likeCounterLabel.text = "Liked posts\n" + String(models.count)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileInfo.delegate = self
        view.backgroundColor = .background
        configureUI()
        configureConstrainst()
        setUIResponder()
        
    }
    

    
    private func configureUI() {
        segmentControl.makeProfileControl()
        segmentControl.addTarget(self, action: #selector(reloadTableViewData), for: .valueChanged)
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(tableViewRefreshControl), for: .valueChanged)
        tableView.refreshControl = refreshControl
        tableView.register(AnimalCell.self, forCellReuseIdentifier: "AnimalCell")
        tableView.isUserInteractionEnabled = true
        tableView.allowsSelection = true

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
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    
    @objc private func reloadTableViewData() {
        tableView.reloadData()
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
        let image = models[indexPath.row].image
        let aspectRatio = image.size.width / image.size.height
        let cellHeight = tableView.bounds.width / aspectRatio + 40
        return cellHeight
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "AnimalCell", for: indexPath) as? AnimalCell {
            if segmentControl.selectedSegmentIndex == 1 {
                cell.configureCell(animalLikedModels[indexPath.row])
            }
            cell.likeManager = self.likeManager
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnimalCell", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt")
    }

    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("didSelectRowAt")
//        let animalModel = [animalPostedModels, animalLikedModels][segmentControl.selectedSegmentIndex][indexPath.row]
//
//        let oneImageVC = OneImageVC(animalModel)
//        self.navigationController?.pushViewController(oneImageVC, animated: true)
//        self.navigationController?.isNavigationBarHidden = false
//    }
    
}




// MARK: - Set Gesture Responder
extension ProfileVC {
    private func setUIResponder() {
        let responder = UITapGestureRecognizer(target: self, action: #selector(responderAction))
        view.addGestureRecognizer(responder)
    }
    
    @objc private func responderAction() {
        profileInfo.nickTextField.resignFirstResponder()
    }
}




// MARK: - ProfileInfoViewDelegate
extension ProfileVC: ProfileInfoViewDelegate {
    func presentTextFieldAlert(_ alert: UIAlertController) {
        present(alert, animated: true)
    }
}
