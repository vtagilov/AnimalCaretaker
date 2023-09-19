import UIKit

class OneImageVC: UIViewController {

    let imageView: UIImageView
    let scrollView = UIScrollView()
    let likeIcon = UIButton()
    let isLiked: Bool
    
    
    init(_ animalModel: AnimalCellModel) {
        self.imageView = UIImageView(image: animalModel.image)
        self.isLiked = false
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .background
        configureUI()
    }
    
    
    private func configureUI() {
        scrollView.maximumZoomScale = 5.0
        scrollView.minimumZoomScale = 1.0
        scrollView.delegate = self
        scrollView.frame = self.view.safeAreaLayoutGuide.layoutFrame
        self.view.addSubview(scrollView)
        
        imageView.contentMode = .scaleAspectFit
        imageView.frame = scrollView.frame
        scrollView.addSubview(imageView)
        
        likeIcon.frame = CGRect(x: self.view.frame.width / 2 - 25,
                                y: self.view.frame.height - 150,
                                width: 50, height: 50)
        likeIcon.setImage(UIImage(systemName: "heart"), for: .normal)
        likeIcon.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        likeIcon.addTarget(self, action: #selector(likeImageAction), for: .touchUpInside)
        self.view.addSubview(likeIcon)
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



extension OneImageVC: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
