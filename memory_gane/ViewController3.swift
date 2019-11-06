
import UIKit

class ViewController3: UIViewController {
    @IBOutlet weak var YouLostLabel: UILabel!
    @IBOutlet weak var YouWonLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(numberOfImages == 10) {
            YouLostLabel.isHidden = true
            YouWonLabel.isHidden = false
        }
        if currentTries == 0 {
            YouLostLabel.isHidden = false
            YouWonLabel.isHidden = true
        }
    }
    
    //Button that restarts the game when you lose it
    @IBAction func tryAgainButton(_ sender: Any) {
        totalScore = 0
        currentTries = 5
        numberOfImages = 2
        imageNumber = 0
        self.performSegue(withIdentifier: "newGame", sender: nil)
    }
}
