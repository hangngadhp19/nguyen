//
//  CourantRetirerViewController.swift
//  projet
//
//  Created by Hang Nga on 23/12/2020.
//

import UIKit
import Firebase

class CourantRetirerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let db = Firestore.firestore()
        
        // db.collection("CompteCourant").addDocument(data: ["id": 1, "client_id": 1, "argent": 1000, "mark": 3, "type_compte": 1, "date_created": Date()])
        
        /*
        let newDocument = db.collection("CompteCourant").document()
        newDocument.setData(["id": newDocument.documentID, "client_id": 1, "argent": 1000, "mark": 3, "type_compte": 1, "date_created": Date()])
        */
        
        
        /*
        db.collection("CompteCourant").addDocument(data: ["id" : 1]) { (error) in
            if let error != nil {
                // there is an error
            } else {
                // operation sucessfully
            }
        }
        */
        
        // delete an field
        // db.collection("CompteCourant").document("1").updateData("argent": FieldValue.delete())
        
        
        
        
        // create or update data
        db.collection("CompteCourant").document("2").setData(["client_id": 1, "argent": 2000, "mark": 2, "type_compte": 1, "date_created": Date()])
/*
        // delete data
        db.collection("CompteCourant").document("1").delete()
        
        // get a data
        db.collection("CompteCourant").document("1").getDocument { (document, error) in
            
            // check error
            if error == nil {
                
                // check data exists
                if document != nil &&  document!.exists {
                    
                    let documentData = document!.data()
                    
                }
            } else {
                
            }
        }
        
        // get all data
        db.collection("CompteCourant").getDocuments { (snapshot, error) in
            if error == nil && snapshot != nil {
                
                for document in snapshot!.documents {
                    
                    let documentData = document.data()
                    
                }
                
            }
        }
        
        // get a subset of document
        db.collection("CompteCourant").whereField("mark", isEqualTo: 3).getDocuments { (snapshot, error) in
            if error == nil && snapshot != nil {
                
                for document in snapshot!.documents {
                    
                    let documentData = document.data()
                    
                }
                
            }
        }
*/
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
