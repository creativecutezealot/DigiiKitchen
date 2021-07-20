//
//  HomeViewController.swift
//  DigiiKitchen
//
//  Created by Admin on 3/15/19.
//  Copyright © 2019 SnowMan. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tabView: UIView!
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var imgHome: UIImageView!
    @IBOutlet weak var lblHome: UILabel!
    
    @IBOutlet weak var imgConnections: UIImageView!
    @IBOutlet weak var lblConnections: UILabel!
    
    @IBOutlet weak var imgFavorites: UIImageView!
    @IBOutlet weak var lblFavorites: UILabel!
    
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblProfile: UILabel!
    
    
    
    var selectedIndex = 0
    var currentIndex = -1
    var currentVC: UIViewController?
    
    var homeNav = UINavigationController()
    var connectionsNav = UINavigationController()
    var favoritesNav = UINavigationController()
    var profileNav = UINavigationController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        onTabSelected(index: 0)
    }
    func onTabSelected(index : Int){
        imgHome.image = UIImage(named: "ic_home")
        lblHome.textColor = UIColor.black
        
        imgConnections.image = UIImage(named: "ic_connections")
        lblConnections.textColor = UIColor.black
        
        imgFavorites.image = UIImage(named: "ic_favorites")
        lblFavorites.textColor = UIColor.black
        
        imgProfile.image =  UIImage(named: "ic_profile")
        lblProfile.textColor = UIColor.black
        
        switch index {
        case 0:
            imgHome.image = UIImage(named: "ic_home_clicked")
            lblHome.textColor =  UIColor(red: 248/255, green: 161/255, blue: 38/255, alpha: 1)
        case 1:
            imgConnections.image = UIImage(named: "ic_connections_clicked")
            lblConnections.textColor =  UIColor(red: 248/255, green: 161/255, blue: 38/255, alpha: 1)
            break
        case 2:
            imgFavorites.image = UIImage(named: "ic_favorites_clicked")
            lblFavorites.textColor =  UIColor(red: 248/255, green: 161/255, blue: 38/255, alpha: 1)
            break
        case 3:
            imgProfile.image = UIImage(named: "ic_profile_clicked")
            lblProfile.textColor =  UIColor(red: 248/255, green: 161/255, blue: 38/255, alpha: 1)
            break
        default:
            break
        }
     
    }
    
    func configureView() {
        tabView.addShadow(location: .top, opacity: 0.1, radius: 2)
        self.selectedIndex = 0
        homeNav = storyboard?.instantiateViewController(withIdentifier: "navHome") as! UINavigationController
        onShowVC(vc: homeNav, nextIndex: self.selectedIndex)
    }
    
    func onShowVC(vc: UIViewController, nextIndex: Int) {
        if currentIndex != nextIndex {
            currentIndex = nextIndex
            //selectedTab(index: nextIndex)
            addChild(vc)
            
            vc.view.frame = mainView.bounds
            vc.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            vc.didMove(toParent: self)
            mainView.addSubview(vc.view)
            
            if currentVC != nil {
                currentVC?.view.removeFromSuperview()
            }
            currentVC = vc
        }
    }
    
    @IBAction func onTappedHome(_ sender: Any) {
        self.selectedIndex = 0
        onTabSelected(index: 0)
        homeNav = storyboard?.instantiateViewController(withIdentifier: "navHome") as! UINavigationController
        onShowVC(vc: homeNav, nextIndex: self.selectedIndex)
    }
    
    @IBAction func onTappedConnections(_ sender: Any) {
        self.selectedIndex = 1
        onTabSelected(index: 1)
        connectionsNav = storyboard?.instantiateViewController(withIdentifier: "navConnections") as! UINavigationController
        onShowVC(vc: connectionsNav, nextIndex: self.selectedIndex)
    }
    
    @IBAction func onTappedFav(_ sender: Any) {
        self.selectedIndex = 2
        onTabSelected(index: 2)
        favoritesNav = storyboard?.instantiateViewController(withIdentifier: "navFavorites") as! UINavigationController
        onShowVC(vc: favoritesNav, nextIndex: self.selectedIndex)
    }
    
    @IBAction func onTappedProfile(_ sender: Any) {
        self.selectedIndex = 3
        onTabSelected(index: 3)
        profileNav = storyboard?.instantiateViewController(withIdentifier: "navProfile") as! UINavigationController
        onShowVC(vc: profileNav, nextIndex: self.selectedIndex)
    }
    
    @IBAction func onChart(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ChartViewController") as! ChartViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
