import UIKit

class FavouritesImagesVC: UIViewController {
        
    var tableView = UITableView()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setFavouriteImages()
        
        configuteUI()
        
        
        
        
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
    
    
    func setFavouriteImages() {
        
    }
    

    
    
    
}




extension FavouritesImagesVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
//        let image b= favouriteImages[indexPath.row]
//        let aspectRatio = image.size.width / image.size.height
//        let cellHeight = tableView.bounds.width / aspectRatio + 40
        
        return 200
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < -250 {
            print("Вы прокрутили таблицу за ее верхнюю границу")
            scrollView.contentOffset.y = 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let cellImage = favouriteImages[indexPath.row]
        let cell = AnimalCell()
//        cell.addImage(cellImage, tableView.frame.width)
        return UITableViewCell()
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
