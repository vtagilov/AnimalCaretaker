import UIKit
import CoreData


class AnimalCell: UITableViewCell {
        
    private var _image = UIImage()
    
    let animalView = UIImageView()
    
    private let likeIcon = UIButton()
    
    
    
    var isLiked: Bool = true
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.isSelected = false
        
    }
    
    
    
    
    func addImage(_ cellImage: UIImage, _ cellWidth: CGFloat) {
        
        let aspectRatio = cellImage.size.width / cellImage.size.height
        let cellHeight = cellWidth / aspectRatio + 50
        
        self.frame = CGRect(x: 0, y: 0, width: cellWidth, height: cellHeight)
        self.backgroundColor = .darkGray
        self.selectionStyle = .none
        animalView.frame = CGRect(x: 0, y: 0, width: cellWidth, height: cellHeight - 50)
        animalView.image = cellImage
        animalView.contentMode = .scaleAspectFill
        animalView.layer.cornerRadius = 15
        animalView.layer.borderWidth = 2.0
        animalView.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        self.addSubview(animalView)
        
        likeIcon.frame = CGRect(x: 10, y: animalView.frame.height, width: 30, height: 30)
        likeIcon.setImage(UIImage(systemName: "heart"), for: .normal)
        likeIcon.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        likeIcon.addTarget(self, action: #selector(likeImageAction), for: .touchUpInside)
        likeIcon.isSelected = isLiked
        self.contentView.addSubview(likeIcon)
        
    }
    
    
    
    @objc func likeImageAction() {
        print("likeImageAction")
        switch likeIcon.isSelected {
        case true:
            likeIcon.isSelected = false
            
        case false:
            likeIcon.isSelected = true            
            
        }
        
    }
    
    
    
}
