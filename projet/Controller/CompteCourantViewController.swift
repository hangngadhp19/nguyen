//
//  CompteCourantViewController.swift
//  projet
//
//  Created by Hang Nga on 17/12/2020.
//

import UIKit

class CompteCourantViewController: UIViewController {
    
    public var item: ClientComptesModel?
    public var deletionHander: (() ->Void)?
    
    @IBOutlet var comptesNomLable: UILabel!
    @IBOutlet var comptesNumLable: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        comptesNomLable.text = item?.titleNomComptes
        comptesNumLable.text = item?.titleNumComptes
        
        /*
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(didTapDelete))
        */
    }
    
    /*
    @objc private func didTapDelete() {
        guard let item = self.item else {
            return
        }
    }
    */

}
