
import UIKit

class ViewController2: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionOfImages: UICollectionView!
    @IBOutlet weak var im: UIImageView!
    var pressedImages: [UIImage] = []
    var shuffledImages: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionOfImages.dataSource = self
        pressedImages = []
        shuffledImages = roundImages.shuffled()
    }
    
    func showToast(message : String) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height/1.1, width: 150, height: 35))
        toastLabel.textColor = UIColor.red
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 3.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    //Crea el número final de celdas del CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return roundImages.count
    }
    
    //Se crea cada celda con el identificador "ImageCell" dentro del CollectionView, forzándola a cambiarse de tipo de dato a un ImageCell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let celda = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        
    //Se añade una imagen al background del botón contenido en cada celda
        celda.imageButton.setBackgroundImage(shuffledImages[indexPath.row], for: UIControl.State.normal)
        return celda
    }
    @IBAction func imageButtonAction(_ sender: UIButton) {
        pressedImages.append(sender.backgroundImage(for: UIControl.State.normal)!)
        sender.isHidden = true
    }
    
    //Resets array and shows images again
    @IBAction func editAgain(_ sender: Any) {
        pressedImages = []
        for i in 0...roundImages.count - 1 {
            let index = IndexPath(row: i, section: 0)
            let cell = collectionOfImages.cellForItem(at: index) as! ImageCell
            cell.imageButton.isHidden = false
        }
    }
    @IBAction func secondScreenButton(_ sender: Any) {
        if (pressedImages == roundImages) {
            totalScore += 1
            numberOfImages += 1
            imageNumber = 0
            self.performSegue(withIdentifier: "backToFirst", sender: nil)
        }
        else if(pressedImages.count == roundImages.count && pressedImages != roundImages){
            print("error")
        }
        else if(pressedImages.count != roundImages.count){
                self.showToast(message: "Select all images!")
        }
    }    
}
