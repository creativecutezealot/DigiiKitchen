//
//  LaunchViewController.swift
//  DigiiKitchen
//
//  Created by Admin on 3/13/19.
//  Copyright © 2019 SnowMan. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var imgState: UIImageView!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    
    var galleryPoint = 0
    var galleryText = ["Create your own recipe and share it with the world !","Uee your ingredients to figure it how what to cook !","Keep track of ingredients and expiration with ours Sensor"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userId = UserDefaults.standard.string(forKey: "user-id")
        if userId != nil {
            if userId!.count > 0 {
                let vc = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                navigationController?.pushViewController(vc, animated: false)
            }
        }
        
        configureView()
    }
    
    func configureView() { 
        
//        btnSignUp.layer.shadowColor = UIColor.black.cgColor
//        btnSignUp.layer.shadowOffset = CGSize(width: 0, height: 2)
//        btnSignUp.layer.shadowRadius = 2
//        btnSignUp.layer.shadowOpacity = 0.3
        let color = UIColor(red: 110/255, green: 173/255, blue: 0/255, alpha: 1).cgColor
        
        btnLogin.layer.borderColor = color
        
    }
    
    @IBAction func onClickSkip(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onClickNext(_ sender: Any) {
      
        galleryPoint = galleryPoint + 1
        if galleryPoint > 2 {
            galleryPoint = 0
        }
        collectionView.scrollToItem(at: IndexPath(item: galleryPoint, section: 0), at: .centeredHorizontally, animated: true)
        
    }
    
    @IBAction func onClickSignUp(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onClickLogin(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    

}
extension LaunchViewController : UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        for c in collectionView.visibleCells {
            let i = collectionView.indexPath(for: c)
            galleryPoint = i!.item
            imgState.image = UIImage(named: "state\(galleryPoint + 1)")
            break
        }
        
    }
    
}
extension LaunchViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return galleryText.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCollectionViewCell", for: indexPath) as! GalleryCollectionViewCell
        cell.imgGallery.image = UIImage(named: "launch\(indexPath.item + 1)")
        cell.lblContent.text = galleryText[indexPath.item]
        return cell
    }
    
}
extension LaunchViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var cellSize = CGSize(width: CGFloat(0), height: 0)
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        cellSize = CGSize(width: CGFloat(width), height: CGFloat(height))
        return cellSize
        
    }
    
}
