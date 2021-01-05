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
        
    @IBOutlet weak var butMenu: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // begin change image for background
        let backgroundImage = UIImage.init(named: "eiffel")
        let backgroundImageView = UIImageView.init(frame: self.view.frame)
        backgroundImageView.image = backgroundImage
        backgroundImageView.contentMode = .scaleAspectFill
        // backgroundImageView.alpha = 0.1
        self.view.insertSubview(backgroundImageView, at: 0)
        // end change image for background
        
        // begin change icon menu for button
        //create a new button
        let butMenu = UIButton(type: .custom)
        //set image for button
        butMenu.setImage(UIImage(named: "icon_menu.jpg"), for: .normal)
        //add function for button
        butMenu.addTarget(self, action: #selector(onClickMenu), for: .touchUpInside)
        //set frame
        butMenu.frame = CGRect(x: 15, y: 10, width: 30, height: 30)
        butMenu.widthAnchor.constraint(equalToConstant: 30).isActive = true
        butMenu.heightAnchor.constraint(equalToConstant: 30).isActive = true
        let barButton = UIBarButtonItem(customView: butMenu)
        //assign button to navigationbar
        self.navigationItem.rightBarButtonItem = barButton
        // end change icon menu for button
        
        tableView.isScrollEnabled = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        onclickTransparentView()
        
        switch indexPath.row {
        case 0:
            guard let vc = storyboard?.instantiateViewController(identifier: "conseiller_login") else {
                fatalError("Unable to create view controller")
            }
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            guard let vc = storyboard?.instantiateViewController(identifier: "client_login") else {
                fatalError("Unable to create view controller")
            }
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            print ("Unable to create view controller")
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
