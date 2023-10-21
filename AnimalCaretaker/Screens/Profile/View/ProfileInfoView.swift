//
//  ProfileInfoView.swift
//  AnimalCaretaker
//
//  Created by Владимир on 20.09.2023.
//

import UIKit

protocol ProfileInfoViewDelegate {
    func presentTextFieldAlert(_ alert: UIAlertController)
    func turnTapRecognizer()
}



class ProfileInfoView: UIView {
    
    var lastName: String?
    
    let likeManager = LikeManager()
    let profileManager = ProfileManager()
    
    var delegate: ProfileInfoViewDelegate?
    let nickTextField = UITextField()
    let profileImageView = UIImageView()

    let likeCounterLabel = UILabel.makeCounterLabel()
    let postsCounterLabel = UILabel.makeCounterLabel()
    
    
    init(delegate: ProfileInfoViewDelegate? = nil) {
        super.init(frame: .null)
        self.delegate = delegate
        configureUI()
        configureConstrainst()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func updateCounterLabels() {
        likeCounterLabel.text = "Liked posts\n" + String(likeManager.getModels().count)
        postsCounterLabel.text = "Posts\n" + String(0)
    }
    
    
    
    private func configureUI() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        updateCounterLabels()
        
        nickTextField.makeProfileNameField(32)
        nickTextField.delegate = self
        
        profileImageView.makeProfileImage()
    }
    
    
    
    private func configureConstrainst() {
        self.addSubview(profileImageView)
        self.addSubview(nickTextField)
        self.addSubview(postsCounterLabel)
        self.addSubview(likeCounterLabel)
        
        NSLayoutConstraint.activate([
            profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 25),
            profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 25),
            profileImageView.heightAnchor.constraint(equalToConstant: 100),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            
            nickTextField.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 25),
            nickTextField.rightAnchor.constraint(equalTo: rightAnchor),
            nickTextField.topAnchor.constraint(equalTo: profileImageView.topAnchor),
            nickTextField.bottomAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            
            postsCounterLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor),
            postsCounterLabel.rightAnchor.constraint(equalTo: nickTextField.centerXAnchor),
            postsCounterLabel.topAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            postsCounterLabel.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor),

            likeCounterLabel.leftAnchor.constraint(equalTo: postsCounterLabel.rightAnchor),
            likeCounterLabel.rightAnchor.constraint(equalTo: rightAnchor),
            likeCounterLabel.topAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            likeCounterLabel.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor)
        ])
    }
    
}




// MARK: - UITextFieldDelegate
extension ProfileInfoView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.turnTapRecognizer()
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == nil { textFieldAlert(); return}
        if textField.text! == "" {
            textFieldAlert()
        } else {
            lastName = textField.text!
            profileManager.saveName(textField.text!)
        }
        delegate?.turnTapRecognizer()
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    private func textFieldAlert() {
        nickTextField.text = lastName
        let alert = UIAlertController(title: "Enter your nickname", message: "Nickname must constains some letters", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        delegate?.presentTextFieldAlert(alert)
    }
    
}
