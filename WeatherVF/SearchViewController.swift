//
//  SearchViewController.swift
//  WeatherVF
//
//  Created by Victor Fundberg on 2018-04-08.
//  Copyright © 2018 Victor Fundberg. All rights reserved.
//

import UIKit

protocol NewCityDelegate {
    func enteredACity (theCity : String)
}

class SearchViewController: UIViewController {
    
    @IBOutlet weak var logoView: UIImageView!
    var gravity : UIGravityBehavior!
    var animator : UIDynamicAnimator!
    var collision : UICollisionBehavior!
    var delegate : NewCityDelegate?
    
    
    @IBOutlet weak var newCityTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logoView.image = UIImage(named: "AppIcon")
        animator = UIDynamicAnimator(referenceView: self.view)
        gravity = UIGravityBehavior(items: [logoView])
        collision = UICollisionBehavior(items: [logoView])
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(gravity)
        animator.addBehavior(collision)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        let newCity = newCityTextField.text!
        navigationController?.popViewController(animated: true)
        delegate?.enteredACity(theCity: newCity)
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
