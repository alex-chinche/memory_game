
import UIKit

class CollectionViewController: UIViewController, UICollectionViewDataSource {
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        .dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return roundImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let celda = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        
        celda.ImageCell.image = roundImages[indexPath.row]
        return celda
    }
}

