import UIKit
import CoreData

class ViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var tableView = UITableView()
    
    var tabBar = UITabBar()
    
    var images = [UIImage]()
    
    var displayedCell = 0
    
    let connector: NetworkConnector
    
    var animalType: AnimalTypes
    
    
    
    init(animalType: AnimalTypes) {
        
        self.animalType = animalType
        connector = NetworkConnector(animalType)
        super.init(nibName: nil, bundle: nil)
        
        switch animalType {
        case .cats:
            self.title = "Cats"
        case .dogs:
            self.title = "Dogs"
        }
        
        
        connector.delegate = self
        configuteUI()
        connector.loadImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .black
        self.navigationController?.isNavigationBarHidden = false
        
    }
    
    
    
    
    
    func configuteUI() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.allowsSelection = true
        tableView.delegate = self
        tableView.backgroundColor = .black
        tableView.contentMode = .scaleToFill
        tableView.contentSize.height = 0
        tableView.backgroundColor = .darkGray
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let image = images[indexPath.row]
        let aspectRatio = image.size.width / image.size.height
        let cellHeight = tableView.bounds.width / aspectRatio + 40
        
        return cellHeight
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellImage = images[indexPath.row]
        let cell = AnimalCell()
        cell.addImage(cellImage, tableView.frame.width)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        displayedCell = indexPath.row
        
        if tableView.numberOfRows(inSection: 0) <= indexPath.row + 5 {
            connector.loadImage()
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cell = tableView.cellForRow(at: indexPath) as? AnimalCell else { return }
        
        guard let image = cell.animalView.image else { return }
        let isLiked = cell.isLiked
        
        
        
        print(indexPath, isLiked)
        
        self.modalPresentationStyle = .fullScreen
        
        present(OneImageVC(image: image, isLiked: isLiked), animated: false, completion: nil)
        
        
        
    }
}



extension ViewController: NetworkProtocol {
    
    func addTableCell(with image: UIImage) {
        images.append(image)
        
        tableView.reloadData()
    }
    
}

