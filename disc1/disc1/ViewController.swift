import UIKit
class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var layout: UICollectionViewFlowLayout!
    //    @IBOutlet weak var collectionViewCell: UICollectionViewCell!
    
    let items = Array(1...20).map { "Item \($0)" }
    
    private var isGridView = false {
        didSet {
            updateLayout()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .white
        setupCollectionView()
        setupNavigationBar()
    }
    
    private func setupCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "CollectionCell")
        
        
        updateLayout()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Dynamic Layout"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Toggle",
            style: .plain,
            target: self,
            action: #selector(toggleLayout)
        )
    }
    
    @objc private func toggleLayout() {
        isGridView.toggle()
    }
    
    private func updateLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        if isGridView {
            let itemSize = (view.bounds.width - 30) / 2
            layout.itemSize = CGSize(width: itemSize, height: itemSize)
        } else {
            layout.itemSize = CGSize(width: view.bounds.width - 20, height: 50)
        }
        
        
        UIView.animate(withDuration: 0.3, animations: {
            self.collectionView.setCollectionViewLayout(layout, animated: true)
            self.collectionView.setContentOffset(.zero, animated: true)
        })
        
            let visibleIndexPaths = collectionView.indexPathsForVisibleItems

            collectionView.reconfigureItems(at: visibleIndexPaths)
    }
    
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as? CustomCollectionViewCell else {
            return UICollectionViewCell()
        }
        let image = UIImage(systemName: "person.circle")
        let title = items[indexPath.item]
        cell.backgroundColor = .systemGreen
        cell.configure(for: isGridView, image: image, title: title)
        return cell
    }
}
