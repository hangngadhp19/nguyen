//
//  UILibraryFunction.swift
//  projet
//
//  Created by Hang Nga on 05/01/2021.
//

import UIKit

class UILibraryFunction: UIViewController {
/*
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
*/

    var navBar:UINavigationBar = UINavigationBar()
    var navItem = UINavigationItem(title: "SomeTitle")

    var screenWidth:CGFloat = 0
    var screenHeight:CGFloat = 0

    var NameHeight:CGFloat = 0
    var NameWidth:CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        let screenSize: CGRect = UIScreen.main.bounds

        screenWidth = screenSize.width
        screenHeight = screenSize.height


        NameHeight = screenHeight * 0.09
        NameWidth = screenWidth
        navBar = UINavigationBar(frame: CGRect(x: 0, y: 30, width: NameWidth, height: NameHeight))
        self.view.addSubview(navBar)

        navBar.setItems([navItem], animated: false)

    }


    //---- Right Bar Button -----
    func rightBarButton() {
        let rightBarButton = UIBarButtonItem(title: "Logout", style: UIBarButtonItem.Style.plain, target: self, action: #selector(didTaplogout))
        navItem.rightBarButtonItem = rightBarButton

    }

    //--- Left Bar Button -----
    func leftBarButton() {

        let leftBarButton = UIBarButtonItem(title: "Home", style: UIBarButtonItem.Style.done, target: self, action: #selector(didTapHome))
        navItem.leftBarButtonItem = leftBarButton

    }

    //----- UI Bar Title ----
    func setTitle(BarTitle:String) {
        navItem = UINavigationItem(title: BarTitle)
        return navBar.setItems([navItem], animated: false)
    }
    
    @objc func didTaplogout() {
        guard let vc = storyboard?.instantiateViewController(identifier: "client_login") as? ClientLoginViewController else {
            return
        }
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func didTapHome() {
        guard let vc = storyboard?.instantiateViewController(identifier: "home") as? HomeViewController else {
            return
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}
