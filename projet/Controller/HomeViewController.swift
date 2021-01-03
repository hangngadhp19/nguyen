//
//  HomeViewController.swift
//  projet
//
//  Created by Hang Nga on 14/12/2020.
//

import UIKit

class HomeViewController: UIViewController {
    
    var transparentView = UIView()
    var tableView = UITableView()
    let height: CGFloat = 100
    var settingArray = ["Conseiller", "Client"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Banque ABC"

        // Do any additional setup after loading the view.
        
        tableView.isScrollEnabled = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "Cell")
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

    @IBAction func onClickMenu(_ sender: Any) {
        
        let window = UIApplication.shared.keyWindow
        
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        transparentView.frame = self.view.frame
        window?.addSubview(transparentView)
        
        let screeSize = UIScreen.main.bounds.size
        tableView.frame = CGRect(x: 0, y: screeSize.height, width: screeSize.width, height: height)
        window?.addSubview(tableView)
        
        let tapGuesture = UITapGestureRecognizer(target: self, action: #selector(onclickTransparentView))
        transparentView.addGestureRecognizer(tapGuesture)
        
        transparentView.alpha = 0
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut) {
            self.transparentView.alpha = 0.5
            
            self.tableView.frame = CGRect(x: 0, y: screeSize.height - self.height, width: screeSize.width, height: self.height)
        } completion: { (true) in
            return
        }

    }
    
    @objc func onclickTransparentView() {
        let screeSize = UIScreen.main.bounds.size
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut) {
            self.transparentView.alpha = 0
            
            self.tableView.frame = CGRect(x: 0, y: screeSize.height, width: screeSize.width, height: self.height)
            
        } completion: { (true) in
            return
        }

        
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? HomeTableViewCell else {
            fatalError("Unable to queue cell")
        }
        cell.lbl.text = settingArray[indexPath.row]
        cell.settingImage.image = UIImage(named: settingArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
