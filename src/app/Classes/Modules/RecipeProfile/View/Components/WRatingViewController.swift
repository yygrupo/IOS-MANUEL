//
//  WRaitingViewController.swift
//  app
//
//  Created by male on 9/24/16.
//  Copyright © 2016 Manuel Alejandro. All rights reserved.
//

import UIKit
import Cosmos

protocol WRatingViewControllerDelegate {
    func setRaiting(rating: Int)
}

class WRatingViewController: UIViewController {
    
    @IBOutlet weak var labelRecipeName: UILabel!
    @IBOutlet weak var labelLocalName: UILabel!
    @IBOutlet weak var raitingView: CosmosView!
    @IBOutlet weak var labelRaiting: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var recipe: WRecipe?
    var delegate: WRatingViewControllerDelegate?
    var currentRaiting: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Private
    private func setupView() {
        raitingView.settings.fillMode = .Full
        raitingView.didFinishTouchingCosmos = { rating in
            self.currentRaiting = Int(rating)
            self.labelRaiting.text = String(self.currentRaiting)
        }
        
        if recipe != nil {
            labelRaiting.text = "\(recipe!.rating!)"
            raitingView.rating = (recipe?.rating?.toDouble)!
            labelLocalName.text = recipe?.local?.name
            labelRecipeName.text = recipe?.name
            
            if recipe?.images?.count > 0 {
                imageView.image = UIImage(named: (recipe?.images![0])!)
            }
        }
    }
    
    @IBAction func closeView() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func setRaiting() {
        delegate?.setRaiting(self.currentRaiting)
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
