//
//  ClientLoginViewController.swift
//  projet
//
//  Created by Hang Nga on 14/12/2020.
//

import UIKit

class ClientLoginViewController: UIViewController {
    
    @IBOutlet weak var txtNom: UITextField!
    @IBOutlet weak var txtPrenom: UITextField!
    @IBOutlet weak var txtTelephone: UITextField!
    
    var arrData = [ClientModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Espace client"

        // Do any additional setup after loading the view.
        
        arrData = ClientData.getAllClientData()
        
        txtNom.text = arrData[0].titleNom
        txtPrenom.text = arrData[0].titlePrenom
        txtTelephone.text = arrData[0].titleTelephone
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
