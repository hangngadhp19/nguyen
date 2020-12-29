//
//  CourantRetirerViewController.swift
//  projet
//
//  Created by Hang Nga on 23/12/2020.
//

import UIKit
import CoreData

class CourantRetirerViewController: UIViewController {

    @IBOutlet weak var txt_argent: UITextField!
    
    public var completionHandler: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func didTapSaveButton(_ sender: Any) {
        
    }
    
}
