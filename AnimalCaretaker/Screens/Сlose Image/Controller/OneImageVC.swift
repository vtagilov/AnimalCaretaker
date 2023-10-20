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
        configureUI()
        configureConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let navController = self.navigationController as! CustomNavigationController
        navController.selectionButton.isUserInteractionEnabled = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let navController = self.navigationController as! CustomNavigationController
        navController.selectionButton.isUserInteractionEnabled = true
    }
    
    
    
    private func configureUI() {
        scrollView.maximumZoomScale = 5.0
        scrollView.minimumZoomScale = 1.0
        scrollView.delegate = self
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        likeIcon.contentHorizontalAlignment = .fill
        likeIcon.contentVerticalAlignment = .fill
        likeIcon.imageView?.tintColor = .white
        likeIcon.setImage(UIImage(systemName: "heart"), for: .normal)
        likeIcon.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        likeIcon.addTarget(self, action: #selector(likeImageAction), for: .touchUpInside)
        likeIcon.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    @objc func likeImageAction() {
        switch likeIcon.isSelected {
        case true:
            likeIcon.isSelected = false
        case false:
            likeIcon.isSelected = true
        }
    }
}

extension OneImageVC {
    private func configureConstraints() {
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        view.addSubview(likeIcon)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            imageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            likeIcon.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -35),
            likeIcon.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            likeIcon.widthAnchor.constraint(equalToConstant: 45),
            likeIcon.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

extension OneImageVC: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
