import UIKit

protocol CloseImageDelegate {
    func likeAction(_ sender: UIButton, _ model: AnimalCellModel, _ numberOfCell: Int)
//    func deletePostAction(_ sender: UIButton, _ model: AnimalCellModel, _ numberOfCell: Int)
}

protocol CloseNewImageDelegate {
    func postAction(_ model: PostModel)
}


class OneImageVC: UIViewController {

    let imageView: UIImageView
    let scrollView = UIScrollView()
//    for new post
    let postButton = UIButton()
    
//    for my posts
    let deleteButton = UIButton()
    
//    for common view
    let likeButton = UIButton.makeLikeButton()
    var likeRecognizer = UITapGestureRecognizer()
    
    
    
    
    var postsManager = PostsManager()
    let isLiked: Bool
    var animalModel: AnimalCellModel? = nil
    var postModel: PostModel? = nil
    var delegate: CloseImageDelegate?
    var newImageDelegate: CloseNewImageDelegate?
    var numberOfCell: Int? = nil
    
    
    init(_ model: PostModel) {
        postModel = model
        self.imageView = UIImageView(image: UIImage(data: model.data))
        imageView.contentMode = .scaleAspectFit
        likeButton.isHidden = true
        self.isLiked = false
        super.init(nibName: nil, bundle: nil)
        self.setPostButton()
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
    
    
    
    func setDeleteButton() {
        postButton.isHidden = true
        deleteButton.isHidden = false
        deleteButton.setTitle("Delete post", for: .normal)
        deleteButton.titleLabel?.font = .boldSystemFont(ofSize: 32)
        deleteButton.addTarget(self, action: #selector(deleteButtonAction), for: .touchUpInside)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        configureDeleteButtonConstraints()
    }
    
    
    
    private func configureUI() {
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.maximumZoomScale = 5.0
        scrollView.minimumZoomScale = 1.0
        scrollView.delegate = self
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        likeButton.isSelected = isLiked
        likeButton.addTarget(self, action: #selector(likeButtonAction), for: .touchUpInside)
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        if !likeButton.isHidden {
            postButton.isHidden = true
        }
    }
    
    
    
    private func setPostButton() {
        postButton.isHidden = false
        postButton.setTitle("Post", for: .normal)
        postButton.setTitleColor(.gray, for: .highlighted)
        postButton.titleLabel?.font = .boldSystemFont(ofSize: 32)
        postButton.addTarget(self, action: #selector(postButtonAction), for: .touchUpInside)
        postButton.translatesAutoresizingMaskIntoConstraints = false
        configurePostButtonConstraints()
    }
    
    
    
    @objc func postButtonAction() {
        newImageDelegate?.postAction(postModel!)
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func deleteButtonAction() {
        print("delete action")
        
    }
    
    @objc func likeButtonAction() {
        delegate?.likeAction(likeButton, animalModel!, numberOfCell!)
        likeButton.isSelected = !likeButton.isSelected
    }
}



// MARK: - set constraints
extension OneImageVC {
    private func configureDeleteButtonConstraints() {
        view.addSubview(deleteButton)
        NSLayoutConstraint.activate([
            deleteButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -35),
            deleteButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            deleteButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func configurePostButtonConstraints() {
        view.addSubview(postButton)
        NSLayoutConstraint.activate([
            postButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -35),
            postButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            postButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
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
        likeRecognizer = UITapGestureRecognizer(target: self, action: #selector(likeButtonAction))
        likeRecognizer.numberOfTapsRequired = 2
        view.addGestureRecognizer(likeRecognizer)
    }
}
