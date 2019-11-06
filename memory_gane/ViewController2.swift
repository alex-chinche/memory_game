
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
    
    //Shows toast showing number of tries left when you miss the round
    func showToast(message : String) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height/1.15, width: 150, height: 35))
        toastLabel.textColor = UIColor.red
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 1.5, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    //Creates the final number of cells
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return roundImages.count
    }
    
    //Creates each cell with id "ImageCell" inside the CollectionView, forcing it to change its data-type to ImageCell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let celda = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        
    //Adds an image to the background of the button contained in each cell
        celda.imageButton.setBackgroundImage(shuffledImages[indexPath.row], for: UIControl.State.normal)
        return celda
    }
    
    //Button that, when pressed, dissapears and adds the image inside to a new array to compare it with the original one and pass the actual round
    @IBAction func imageButtonAction(_ sender: UIButton) {
        pressedImages.append(sender.backgroundImage(for: UIControl.State.normal)!)
        sender.isHidden = true
    }
    
    //Resets array and shows images again
    @IBAction func editAgainButton(_ sender: Any) {
        pressedImages = []
        for i in 0...roundImages.count - 1 {
            let index = IndexPath(row: i, section: 0)
            let cell = collectionOfImages.cellForItem(at: index) as! ImageCell
            cell.imageButton.isHidden = false
        }
    }
    
    //Button that checks if the arrays compared are equal or not to pass the round
    @IBAction func confirmButton(_ sender: Any) {
        if (pressedImages == roundImages) {
            totalScore += 1
            numberOfImages += 1
            imageNumber = 0
            if (numberOfImages == 10) {
                self.performSegue(withIdentifier: "finalScreen", sender: nil)
            }
            else {
            self.performSegue(withIdentifier: "backToFirst", sender: nil)
            }
        }
        else if(pressedImages.count == roundImages.count && pressedImages != roundImages){
            currentTries -= 1
            if(currentTries > 1) {
                self.showToast(message: "Error. \(currentTries) tries left")
            }
            else if(currentTries == 1) {
                self.showToast(message: "Error. \(currentTries) try left")
            }
            else if(currentTries == 0) {
                self.showToast(message: "You lost!")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.performSegue(withIdentifier: "finalScreen", sender: nil)
                }
            }
        }
        else if(pressedImages.count != roundImages.count){
                self.showToast(message: "Select all images!")
        }
    }    
}

