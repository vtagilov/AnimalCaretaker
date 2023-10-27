import UIKit
import CoreData


class AnimalCell: UITableViewCell {
    
    private let animalView = UIImageView()
    private let likeButton = UIButton.makeLikeButton()
    private var animalModel: AnimalCellModel!
    private var postModel: PostModel!
    
    var delegate: AnimalCellDelegate?
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func configureCell(_ animalModel: AnimalCellModel) {
        configureUI()
        setConstraints()
        self.animalView.image = animalModel.image
        self.animalModel = animalModel
        likeButton.isHidden = false
    }
    
    
    func configureCell(_ model: PostModel) {
        configureUI()
        setConstraints()
        self.animalView.image = UIImage(data: model.data)
        self.postModel = model
        likeButton.isHidden = true
    }
    
    
    
    func setLikeProperty(_ isLiked: Bool) {
        likeButton.isSelected = isLiked
    }
    
    
    private func configureUI() {
        self.backgroundColor = .none
        self.selectionStyle = .none
        
        animalView.contentMode = .scaleAspectFill
        animalView.clipsToBounds = true
        animalView.layer.cornerRadius = 15
        animalView.layer.borderWidth = 2.0
        animalView.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        animalView.translatesAutoresizingMaskIntoConstraints = false
        
        likeButton.addTarget(self, action: #selector(likeImageAction), for: .touchUpInside)
        likeButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    
    private func setConstraints() {
        self.addSubview(animalView)
        self.contentView.addSubview(likeButton)
        
        NSLayoutConstraint.activate([
            animalView.topAnchor.constraint(equalTo: contentView.topAnchor),
            animalView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50),
            animalView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            animalView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            
            likeButton.topAnchor.constraint(equalTo: animalView.bottomAnchor, constant: 5),
            likeButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            likeButton.rightAnchor.constraint(equalTo: animalView.rightAnchor, constant: -5),
            likeButton.widthAnchor.constraint(equalToConstant: 40),
            likeButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    
    
    @objc func likeImageAction() {
        self.delegate?.likeImageAction(animalModel)
        UIView.animate(withDuration: 1.5) {
            self.likeButton.isSelected = !self.likeButton.isSelected
        }
    }
    
}
