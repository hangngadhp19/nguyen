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
        // connect db
        let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.persistentContainer.viewContext
        
        // get data
        var id_deposer = 0
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CompteCourant")
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
        
        let newCompteCourant = NSEntityDescription.insertNewObject(forEntityName: "CompteCourant", into: context)
        
        newCompteCourant.setValue(Float(txt_argent_depose.text ?? "0"), forKey: "argent")
        newCompteCourant.setValue(1, forKey: "client_id")
        newCompteCourant.setValue(Date(), forKey: "date_created")
        newCompteCourant.setValue(id_deposer + 1, forKey: "id")
        newCompteCourant.setValue(2, forKey: "mark")
        newCompteCourant.setValue(1, forKey: "type_compte")
        
        do {
          try context.save()
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
        
        // reload tableView data which added
        guard let vc = storyboard?.instantiateViewController(identifier: "comptecourant") as? CompteCourantViewController else {
            return
        }
        
        vc.completionHandler = { [weak self] in
            vc.refresh()
        }
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
