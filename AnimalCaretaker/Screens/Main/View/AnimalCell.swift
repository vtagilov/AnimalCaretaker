import UIKit
import CoreData


class AnimalCell: UITableViewCell {
    
    private let animalView = UIImageView()
    private let likeIcon = UIButton()
    private var animalModel: AnimalCellModel!
    
    var likeManager: LikeManager? {
        didSet {
            guard let likeManager = likeManager else { return }
            if likeManager.isLiked(animalModel) {
                likeIcon.isSelected = true
            }
        }
    }
    
    
    
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
        self.addSubview(animalView)
        
        likeIcon.setImage(UIImage(systemName: "heart"), for: .normal)
        likeIcon.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        likeIcon.addTarget(self, action: #selector(likeImageAction), for: .touchUpInside)
        likeIcon.backgroundColor = .black
        likeIcon.contentMode = .scaleAspectFit
        likeIcon.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(likeIcon)
    }
    
    
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            animalView.topAnchor.constraint(equalTo: contentView.topAnchor),
            animalView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50),
            animalView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            animalView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            
            likeIcon.topAnchor.constraint(equalTo: animalView.bottomAnchor),
            likeIcon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            likeIcon.rightAnchor.constraint(equalTo: animalView.rightAnchor),
            likeIcon.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    
    
    @objc func likeImageAction() {
        switch likeIcon.isSelected {
        case true:
            likeIcon.isSelected = false
            likeManager?.removeLike(animalModel)
        case false:
            likeIcon.isSelected = true
            likeManager?.addLike(animalModel)
        }
    }
    
}
