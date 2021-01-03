//
//  CourantDeposerViewController.swift
//  projet
//
//  Created by Hang Nga on 23/12/2020.
//

import UIKit
import CoreData

class CourantDeposerViewController: UIViewController {
    
    @IBOutlet weak var txt_argent_depose: UITextField!
    
    public var completionHandler: (() -> Void)?
    
    public var selectedTypeCompte: Int = 1
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()
    
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
        var id_deposer = 0
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: varEntityName)
        request.returnsObjectsAsFaults = false
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: false)]
        request.fetchLimit = 1
        do {
            let result = try context.fetch(request) as! [NSManagedObject]
            id_deposer = result[0].value(forKey: "id") as! Int
        }
        catch let error as NSError {
            print("\(error)")
        }
        // end get data to get id
        
        // insert data
        let newCompteCourant = NSEntityDescription.insertNewObject(forEntityName: varEntityName, into: context)
        newCompteCourant.setValue(Float(txt_argent_depose.text ?? "0")!, forKey: "argent")
        newCompteCourant.setValue(idUserLogined, forKey: "client_id")
        newCompteCourant.setValue(Date(), forKey: "date_created")
        newCompteCourant.setValue(id_deposer + 1, forKey: "id")
        newCompteCourant.setValue(2, forKey: "mark")
        newCompteCourant.setValue(typeCompte, forKey: "type_compte")
        newCompteCourant.setValue(false, forKey: "mark_recu")
        do {
          try context.save()
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
        // end insert data
        
        // get data from table client to sum money
        let id_client = idUserLogined
        var argent_solde:Float = 0
        let requestSolde = NSFetchRequest<NSFetchRequestResult>(entityName: "Client")
        requestSolde.returnsObjectsAsFaults = false
        let predicate = NSPredicate(format: "id = %i", id_client)
        requestSolde.predicate = predicate
        do {
            let result = try context.fetch(requestSolde) as! [NSManagedObject]
            argent_solde = result[0].value(forKey: "compte_\(varNom)_solde") as! Float
        }
        catch let error as NSError {
            print("\(error)")
        }
        // end get data from table client to sum money
        
        // update money in table client
        var argentCaculated:Float = 0
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
                    argentCaculated = Float(txt_argent_depose.text ?? "0")! + argent_solde
                    managedObject.setValue(argentCaculated, forKey: "compte_\(varNom)_solde")
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
        
        
        
        
        /*
        // update data
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Client")
        let id_1 = 2
        let predicate = NSPredicate(format: "id = %i", id_1 as Int)
        fetchRequest.predicate = predicate
        do {
            let  rs = try context.fetch(fetchRequest)
            for result in rs as [NSManagedObject] {
                // update
                do {
                    let managedObject = rs[0]
                    //managedObject.setValue(Float(txt_argent_depose.text ?? "0"), forKey: "argent")
                    managedObject.setValue(Float(1010), forKey: "compte_courant_solde")
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
        // end update data
        */
        
        /*
        // delete data
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CompteCourant")
        let id_1 = 17
        let predicate = NSPredicate(format: "id = %i", id_1 as Int)
        fetchRequest.predicate = predicate
        do {
            let  rs = try context.fetch(fetchRequest)
            for result in rs as [NSManagedObject] {
                // update
                do {
                    let managedObject = rs[0]
                    try context.delete(managedObject)
                    try context.save()
                    print("delete successfull")
                } catch let error as NSError {
                    print("Could not Delete. \(error), \(error.userInfo)")
                }
                //end update
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        // end delete data
        */
        
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
    
}
