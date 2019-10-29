
import UIKit

var totalScore = 0
var numberOfImages = 2
var imageLibrary: [UIImage] = [#imageLiteral(resourceName: "image3"), #imageLiteral(resourceName: "image2"), #imageLiteral(resourceName: "image1"), #imageLiteral(resourceName: "image7"), #imageLiteral(resourceName: "image4"), #imageLiteral(resourceName: "image6"), #imageLiteral(resourceName: "image5"), #imageLiteral(resourceName: "image8"), #imageLiteral(resourceName: "image9")]
var roundImages: [UIImage] = []
var imageNumber = 0

class ViewController: UIViewController {
    
    var secondsBetweenImages = 0.0

    @IBOutlet weak var scoreText: UILabel!
    @IBOutlet weak var changableImage: UIImageView!
    @IBOutlet weak var playButtonOutlet: UIButton!
    @IBOutlet weak var imageNumberText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageLibrary = [#imageLiteral(resourceName: "image3"), #imageLiteral(resourceName: "image2"), #imageLiteral(resourceName: "image1"), #imageLiteral(resourceName: "image7"), #imageLiteral(resourceName: "image4"), #imageLiteral(resourceName: "image6"), #imageLiteral(resourceName: "image5"), #imageLiteral(resourceName: "image8"), #imageLiteral(resourceName: "image9")]
        roundImages = []
        scoreText.text = "Score: \(totalScore)"
        imageNumberText.text = "Image number: 0"
        playButtonOutlet.isHidden = false
    }
    
    @IBAction func playButton(_ sender: Any) {
        
        playButtonOutlet.isHidden = true
        for _ in 1...numberOfImages {
            let chosenImage = imageLibrary.randomElement()
            roundImages.append(chosenImage!)
            DispatchQueue.main.asyncAfter(deadline: .now() + secondsBetweenImages) {
                self.changableImage.image = chosenImage
                imageNumber += 1
                self.imageNumberText.text = "Image number: \(imageNumber)"
            }
            secondsBetweenImages += 2.0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + secondsBetweenImages) {
            self.performSegue(withIdentifier: "solveGame", sender: nil)
        }
    }
}

