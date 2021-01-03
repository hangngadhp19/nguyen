//
//  VirerViewController.swift
//  projet
//
//  Created by Hang Nga on 03/01/2021.
//

import UIKit
import CoreData
import Foundation

class VirerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var txtCompteDebiter: UITextField!
    @IBOutlet weak var txtMontant: UITextField!
    @IBOutlet weak var pickerTextField : UITextField!
    
    public var completionHandler: (() -> Void)?
    
    public var selectedTypeCompte: Int = 1
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()
    
    let typeCompteLivreta = ["", "Compte Courant", "Compte Épargne"]
    let typeCompteEpargne = ["", "Compte Courant", "Compte Livret A"]
    let typeCompteCourant = ["", "Compte Livret A", "Compte Épargne"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerTextField.inputView = pickerView
        
        if selectedTypeCompte == 2 {
            txtCompteDebiter.text = "Compte Livret A"
        } else if selectedTypeCompte == 3 {
            txtCompteDebiter.text = "Compte Épargne"
        } else {
            txtCompteDebiter.text = "Compte Courant"
        }
        txtCompteDebiter.isUserInteractionEnabled = false
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if selectedTypeCompte == 2 {
            return typeCompteLivreta.count
        } else if selectedTypeCompte == 3 {
            return typeCompteEpargne.count
        } else {
            return typeCompteCourant.count
        }
    }
    
    // This function sets the text of the picker view to the content of the "salutations" array
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if selectedTypeCompte == 2 {
            return typeCompteLivreta[row]
        } else if selectedTypeCompte == 3 {
            return typeCompteEpargne[row]
        } else {
            return typeCompteCourant[row]
        }
    }
    
    // When user selects an option, this function will set the text of the text field to reflect
    // the selected option.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if selectedTypeCompte == 2 {
            pickerTextField.text = typeCompteLivreta[row]
        } else if selectedTypeCompte == 3 {
            pickerTextField.text = typeCompteEpargne[row]
        } else {
            pickerTextField.text = typeCompteCourant[row]
        }
    }
    
    @IBAction func didTapSave(_ sender: Any) {
        
        let textSelected = pickerTextField.text as! String
        var typeCompteSelected = 1
        var varNomRecu = "courant"
        var varEntityNameRecu = "CompteCourant"
        
        if textSelected == "Compte Épargne" {
            typeCompteSelected = 3
        } else if textSelected == "Compte Livret A" {
            typeCompteSelected = 2
        } else {
            typeCompteSelected = 1
        }
        
        if typeCompteSelected == 1 {
            varNomRecu = "courant"
            varEntityNameRecu = "CompteCourant"
        } else if typeCompteSelected == 2 {
            varNomRecu = "livreta"
            varEntityNameRecu = "CompteLivretA"
        } else {
            varNomRecu = "epargne"
            varEntityNameRecu = "CompteEpargne"
        }
        
        let typeCompte = selectedTypeCompte
        
        // get id User
        let defaults = UserDefaults.standard
        let idUserLogined = defaults.value(forKey: "idUser") as! Int
        // end get id User
        
        var varEntityName = "CompteCourant"
        var varNom = "courant"
        
        if typeCompte == 1 {
            varEntityName = "CompteCourant"
            varNom = "courant"
        } else if typeCompte == 2 {
            varEntityName = "CompteLivretA"
            varNom = "livreta"
        } else {
            varEntityName = "CompteEpargne"
            varNom = "epargne"
        }
        
        // connect db
        let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.persistentContainer.viewContext
        
        // get data
        var id_retirer = 0
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: varEntityName)
        request.returnsObjectsAsFaults = false
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: false)]
        request.fetchLimit = 1
        do {
            let result = try context.fetch(request) as! [NSManagedObject]
            id_retirer = result[0].value(forKey: "id") as! Int
        }
        catch let error as NSError {
            print("\(error)")
        }
        // end get data to get id
        
        // get data from table client to sum money
        let id_client = idUserLogined
        var argent_solde:Float = 0
        var argent_compte_recu_solde:Float = 0
        let requestSolde = NSFetchRequest<NSFetchRequestResult>(entityName: "Client")
        requestSolde.returnsObjectsAsFaults = false
        let predicate = NSPredicate(format: "id = %i", id_client)
        requestSolde.predicate = predicate
        do {
            let result = try context.fetch(requestSolde) as! [NSManagedObject]
            argent_solde = result[0].value(forKey: "compte_\(varNom)_solde") as! Float
            
            // compte recu quand vire
            argent_compte_recu_solde = result[0].value(forKey: "compte_\(varNomRecu)_solde") as! Float
        }
        catch let error as NSError {
            print("\(error)")
        }
        // end get data from table client to sum money
        
        // update money in table client
        var argentCaculated:Float = 0
        var argentCaculatedRecu:Float = 0
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Client")
        let id_1 = idUserLogined
        let predicateClient = NSPredicate(format: "id = %i", id_1)
        fetchRequest.predicate = predicateClient
        do {
            let  rs = try context.fetch(fetchRequest)
            for result in rs as [NSManagedObject] {
                // update
                do {
                    let managedObject = rs[0]
                    argentCaculated = argent_solde - Float(txtMontant.text ?? "0")!
                    argentCaculatedRecu = argent_compte_recu_solde + Float(txtMontant.text ?? "0")!
                    
                    // test argent < 10: compte livreta
                    if (argentCaculated < 10) && (typeCompte == 2) {
                        displayMyAlertMessage(userMessage: "Ce compte doit être d'au moins 10 euros, sinon le compte sera fermé.")
                        return
                    } else if (argentCaculated <= 0) && (typeCompte == 3) {
                        displayMyAlertMessage(userMessage: "L'argent de ce compte est égal à 0, le compte sera fermé.")
                        return
                    }
                    // end test argent < 10
                    
                    managedObject.setValue(argentCaculated, forKey: "compte_\(varNom)_solde")
                    
                    // update argent in compte vired
                    managedObject.setValue(argentCaculatedRecu, forKey: "compte_\(varNomRecu)_solde")
                    
                    try context.save()
                    print("update successfull")
                } catch let error as NSError {
                    print("Could not Update. \(error), \(error.userInfo)")
                }
                //end update
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        // end update money in table client
        
        // insert data
        let newCompteCourant = NSEntityDescription.insertNewObject(forEntityName: varEntityName, into: context)
        newCompteCourant.setValue(Float(txtMontant.text ?? "0")!, forKey: "argent")
        newCompteCourant.setValue(idUserLogined, forKey: "client_id")
        newCompteCourant.setValue(Date(), forKey: "date_created")
        newCompteCourant.setValue(id_retirer + 1, forKey: "id")
        newCompteCourant.setValue(1, forKey: "mark")
        newCompteCourant.setValue(typeCompteSelected, forKey: "type_compte")
        newCompteCourant.setValue(false, forKey: "mark_recu")
        do {
          try context.save()
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
        // end insert data
        
        // get data to get id compte recu
        var id_retirer_recu = 0
        let request_recu = NSFetchRequest<NSFetchRequestResult>(entityName: varEntityNameRecu)
        request_recu.returnsObjectsAsFaults = false
        request_recu.sortDescriptors = [NSSortDescriptor(key: "id", ascending: false)]
        request_recu.fetchLimit = 1
        do {
            let result = try context.fetch(request_recu) as! [NSManagedObject]
            id_retirer_recu = result[0].value(forKey: "id") as! Int
        }
        catch let error as NSError {
            print("\(error)")
        }
        // get data to get id compte recu
        
        // insert data into compte recu
        let newCompteRecu = NSEntityDescription.insertNewObject(forEntityName: varEntityNameRecu, into: context)
        newCompteRecu.setValue(Float(txtMontant.text ?? "0")!, forKey: "argent")
        newCompteRecu.setValue(idUserLogined, forKey: "client_id")
        newCompteRecu.setValue(Date(), forKey: "date_created")
        newCompteRecu.setValue(id_retirer_recu + 1, forKey: "id")
        newCompteRecu.setValue(1, forKey: "mark")
        newCompteRecu.setValue(true, forKey: "mark_recu")
        newCompteRecu.setValue(typeCompte, forKey: "type_compte")
        do {
          try context.save()
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
        // end insert data into compte recu
        
        // reload tableView data which added
        guard let vc = storyboard?.instantiateViewController(identifier: "comptecourant") as? CompteCourantViewController else {
            return
        }
        vc.completionHandler = { [weak self] in
            vc.refresh()
        }
        
        vc.typeComptesPass = typeCompte
        vc.titleNomComptes = varNom
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.title = "Comptes \(varNom) "  + ":" + " \(argentCaculated)"
        navigationController?.pushViewController(vc, animated: true)
        // end reload tableView data which added
    
    }
    
    func displayMyAlertMessage(userMessage:String) {

        let alert = UIAlertController(title: "Alerte!", message: userMessage, preferredStyle: UIAlertController.Style.alert)

        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)

        alert.addAction(okAction)

        self.present(alert, animated: true, completion: nil)
    }
}
