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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerTextField.inputView = pickerView
        
        if selectedTypeCompte == 2 {
            txtCompteDebiter.text = "Compte Livret A"
        } else {
            txtCompteDebiter.text = "Compte Épargne"
        }
        txtCompteDebiter.isUserInteractionEnabled = false
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if selectedTypeCompte == 2 {
            return typeCompteLivreta.count
        } else {
            return typeCompteEpargne.count
        }
    }
    
    // This function sets the text of the picker view to the content of the "salutations" array
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if selectedTypeCompte == 2 {
            return typeCompteLivreta[row]
        } else {
            return typeCompteEpargne[row]
        }
    }
    
    // When user selects an option, this function will set the text of the text field to reflect
    // the selected option.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if selectedTypeCompte == 2 {
            pickerTextField.text = typeCompteLivreta[row]
        } else {
            pickerTextField.text = typeCompteEpargne[row]
        }
    }
    
    @IBAction func didTapSave(_ sender: Any) {
        
    }
    

}
