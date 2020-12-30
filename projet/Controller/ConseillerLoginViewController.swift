//
//  ConseillerLoginViewController.swift
//  projet
//
//  Created by Hang Nga on 19/12/2020.
//

import UIKit
import CoreData

class ConseillerLoginViewController: UIViewController {

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

    @IBAction func didCreateConseiller(_ sender: Any) {
        // connect db
        let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.persistentContainer.viewContext
        
        // get data
        var id = 0
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Conseiller")
        request.returnsObjectsAsFaults = false
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: false)]
        request.fetchLimit = 1
        do {
            let result = try context.fetch(request) as! [NSManagedObject]
            if result.count > 0 {
                id = result[0].value(forKey: "id") as! Int
            }
        }
        catch let error as NSError {
            print("\(error)")
        }
        // end get data to get id
        
        // insert data
        let newCompteCourant = NSEntityDescription.insertNewObject(forEntityName: "Conseiller", into: context)
        newCompteCourant.setValue(id + 1, forKey: "id")
        newCompteCourant.setValue("admin", forKey: "password")
        newCompteCourant.setValue("admin", forKey: "username")
        do {
          try context.save()
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
        // end insert data
    }
    
    @IBAction func didCreateClient(_ sender: Any) {
        // connect db
        let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.persistentContainer.viewContext
        
        // get data
        var id = 0
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Client")
        request.returnsObjectsAsFaults = false
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: false)]
        request.fetchLimit = 1
        do {
            let result = try context.fetch(request) as! [NSManagedObject]
            if result.count > 0 {
                id = result[0].value(forKey: "id") as! Int
            }
        }
        catch let error as NSError {
            print("\(error)")
        }
        // end get data to get id
        
        // insert data
        let newCompteCourant = NSEntityDescription.insertNewObject(forEntityName: "Client", into: context)
        newCompteCourant.setValue(id + 1, forKey: "id")
        newCompteCourant.setValue("nguyen", forKey: "nom")
        newCompteCourant.setValue("nga", forKey: "prenom")
        newCompteCourant.setValue("8 massena 75013", forKey: "adresse")
        newCompteCourant.setValue("1234567890", forKey: "telephone")
        newCompteCourant.setValue(1, forKey: "conseiller_id")
        newCompteCourant.setValue("8007041149604", forKey: "num_compte")
        newCompteCourant.setValue(1000, forKey: "compte_courant_solde")
        newCompteCourant.setValue(10, forKey: "compte_livreta_solde")
        newCompteCourant.setValue(200, forKey: "compte_epargne_solde")
        newCompteCourant.setValue(false, forKey: "is_deleted")
        newCompteCourant.setValue(Date(), forKey: "created_date")
        newCompteCourant.setValue(Date(), forKey: "updated_date")
        do {
          try context.save()
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
        // end insert data
    }
    
}
