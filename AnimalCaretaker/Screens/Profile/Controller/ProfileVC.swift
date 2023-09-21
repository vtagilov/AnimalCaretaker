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
        
        animalLikedModels = likeManager.getModels()
        print("viewWillAppear, count: ", animalLikedModels.count)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        configureUI()
        configureConstrainst()
        setUIResponder()
    }
    

    
    private func configureUI() {
        segmentControl.insertSegment(withTitle: "My Post", at: 0, animated: true)
        segmentControl.insertSegment(withTitle: "Liked", at: 1, animated: true)
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(reloadTableViewData), for: .valueChanged)
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        
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
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    
    @objc private func reloadTableViewData() {
        tableView.reloadData()
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





extension ProfileVC: ProfileInfoViewDelegate {
    func preesntTextFieldAlert(_ alert: UIAlertController) {
        present(alert, animated: true)
    }
}
