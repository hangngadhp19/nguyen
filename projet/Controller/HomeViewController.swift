//
//  HomeViewController.swift
//  projet
//
//  Created by Hang Nga on 14/12/2020.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Banque ABC"

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
    
    @IBAction func didTapConseillerButton() {
        guard let vc = storyboard?.instantiateViewController(identifier: "conseiller_login") as? ConseillerLoginViewController else {
            return
        }
        
        vc.title = "Connexion Conseiller"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
        
    }

}
