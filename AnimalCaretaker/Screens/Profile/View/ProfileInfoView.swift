//
//  ProfileInfoView.swift
//  AnimalCaretaker
//
//  Created by Владимир on 20.09.2023.
//

import UIKit

protocol ProfileInfoViewDelegate {
    func preesntTextFieldAlert(_ alert: UIAlertController)
}



class ProfileInfoView: UIView {
    
    let profileManager = ProfileManager()
    
    var delegate: ProfileInfoViewDelegate?
    let nickTextField = UITextField()
    let profileImageView = UIImageView()

    let likeCounterLabel = UILabel()
    let postsCounterLabel = UILabel()
    
    
    init(delegate: ProfileInfoViewDelegate? = nil) {
        super.init(frame: .null)
        self.delegate = delegate
        
        configureUI()
        configureConstrainst()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
    private func configureUI() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        nickTextField.makeProfileNameField(32)
        nickTextField.delegate = self
        
        profileImageView.makeProfileImage()
    }
    
    
    
    private func configureConstrainst() {
        self.addSubview(profileImageView)
        self.addSubview(nickTextField)
        
        NSLayoutConstraint.activate([
            profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 25),
            profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 25),
            profileImageView.heightAnchor.constraint(equalToConstant: 100),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            
            nickTextField.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 25),
            nickTextField.rightAnchor.constraint(equalTo: rightAnchor),
            nickTextField.topAnchor.constraint(equalTo: profileImageView.topAnchor),
            nickTextField.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor)
        ])
    }
    
}




// MARK: - UITextFieldDelegate
extension ProfileInfoView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == nil { textFieldAlert(); return}
        if textField.text! == "" {
            textFieldAlert()
        } else {
            profileManager.saveName(textField.text!)
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    private func textFieldAlert() {
        let alert = UIAlertController(title: "Enter your nickname", message: "Nickname must constains some letters", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        delegate?.preesntTextFieldAlert(alert)
    }
    
}
