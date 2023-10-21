import UIKit

protocol CloseImageDelegate {
    func likeAction(_ sender: UIButton, _ model: AnimalCellModel, _ numberOfCell: Int)
}


class OneImageVC: UIViewController {

    let imageView: UIImageView
    let scrollView = UIScrollView()
    let likeButton = UIButton.makeLikeButton()
    var tapRecognizer = UITapGestureRecognizer()
    
    let isLiked: Bool
    let animalModel: AnimalCellModel
    var delegate: CloseImageDelegate?
    
    let numberOfCell: Int
    
    
    init(_ image: UIImage) {
        self.imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        self.numberOfCell = 0
        self.animalModel = AnimalCellModel(id: "", image: UIImage(), data: Data())
        likeButton.isHidden = true
        self.isLiked = true
        super.init(nibName: nil, bundle: nil)
    }
    
    init(_ numberOfCell: Int, _ animalModel: AnimalCellModel, _ isLiked: Bool) {
        self.numberOfCell = numberOfCell
        self.animalModel = animalModel
        self.isLiked = isLiked
        self.imageView = UIImageView(image: animalModel.image)
        super.init(nibName: nil, bundle: nil)
        configureTapRecognizer()
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
        
        likeButton.isSelected = isLiked
        likeButton.addTarget(self, action: #selector(likeButtonAction), for: .touchUpInside)
        likeButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    @objc func likeButtonAction() {
        delegate?.likeAction(likeButton, animalModel, numberOfCell)
        likeButton.isSelected = !likeButton.isSelected
    }
}



// MARK: - set constraints
extension OneImageVC {
    private func configureConstraints() {
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        view.addSubview(likeButton)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            imageView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            likeButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -35),
            likeButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            likeButton.widthAnchor.constraint(equalToConstant: 45),
            likeButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}




//MARK: - UIScrollViewDelegate
extension OneImageVC: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}



//MARK: - configure TapRecognizer
extension OneImageVC {
    private func configureTapRecognizer() {
        tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(likeButtonAction))
        tapRecognizer.numberOfTapsRequired = 2
        view.addGestureRecognizer(tapRecognizer)
    }
}
