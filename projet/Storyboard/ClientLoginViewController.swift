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
        
        // get user_defaut: marked logined
        let defaults = UserDefaults.standard
        defaults.set(false, forKey: "isUserLoggedIn")
        defaults.set(0, forKey: "idUser")
        defaults.set("", forKey: "nomUser")
        defaults.set("", forKey: "prenomUser")
        // end get user_defaut: marked logined
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func displayMyAlertMessage(userMessage:String) {

        let alert = UIAlertController(title: "Alerte!", message: userMessage, preferredStyle: UIAlertController.Style.alert)

        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)

        alert.addAction(okAction)

        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func didSubmit(_ sender: Any) {
        
        arrData = ClientData.getAllClientData()
        
        let lblNom = txtNom.text!
        let lblPrenom = txtPrenom.text!
        let lblTelephone = txtTelephone.text!
        
        if ((lblNom.isEmpty) || (lblPrenom.isEmpty) || (lblTelephone.isEmpty)) {
            displayMyAlertMessage(userMessage: "Vous n'avez pas rempli tous les champs.")
            return
        } else {
            for result in arrData {
                
                let valueNom = result.titleNom
                let trimmedValueNom = valueNom.trimmingCharacters(in: .whitespacesAndNewlines)
                let trimmedLblNom = lblNom.trimmingCharacters(in: .whitespacesAndNewlines)
                
                let valuePreNom = result.titlePrenom
                let trimmedValuePreNom = valuePreNom.trimmingCharacters(in: .whitespacesAndNewlines)
                let trimmedLblPreNom = lblPrenom.trimmingCharacters(in: .whitespacesAndNewlines)
                
                let valueTelephone = result.titleTelephone
                let trimmedValueTelephone = valueTelephone.trimmingCharacters(in: .whitespacesAndNewlines)
                let trimmedLblTelephone = lblTelephone.trimmingCharacters(in: .whitespacesAndNewlines)
                
                if ((trimmedValueNom.elementsEqual(trimmedLblNom)) == true) && ((trimmedValuePreNom.elementsEqual(trimmedLblPreNom)) == true) && ((trimmedValueTelephone.elementsEqual(trimmedLblTelephone)) == true) {
                
                    UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                    UserDefaults.standard.set(result.titleId, forKey: "idUser")
                    UserDefaults.standard.set(valueNom, forKey: "nomUser")
                    UserDefaults.standard.set(valuePreNom, forKey: "prenomUser")
                    UserDefaults.standard.synchronize()
                    
                    // move form continue
                    guard let vc = storyboard?.instantiateViewController(identifier: "cell") as? ClientEspaceViewController else {
                        return
                    }
                    vc.navigationItem.largeTitleDisplayMode = .never
                    navigationController?.pushViewController(vc, animated: true)
                    // end move form continue
                    
                    break
                    
                } else {
                    displayMyAlertMessage(userMessage: "Il n'y a pas de clients avec ces informations")
                    continue
                }
            }
            
        }
         
    }
}
