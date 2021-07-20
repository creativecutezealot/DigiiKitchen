//
//  SignUpViewController.swift
//  DigiiKitchen
//
//  Created by Admin on 3/13/19.
//  Copyright © 2019 SnowMan. All rights reserved.
//

import UIKit
import CropViewController
import SkyFloatingLabelTextField

class SignUpViewController: UIViewController {

    @IBOutlet weak var txtFirstName: SkyFloatingLabelTextField!
    
    @IBOutlet weak var txtLastName: SkyFloatingLabelTextField!
    
    @IBOutlet weak var txtUserName: SkyFloatingLabelTextField!
    
    @IBOutlet weak var txtEmail: SkyFloatingLabelTextField!
    
    @IBOutlet weak var txtBirthday: SkyFloatingLabelTextField!
    
    @IBOutlet weak var imgProfileAvarta: UIImageView!
    
    var datePicker : UIDatePicker!
    
    let imagePickerController = UIImagePickerController()
    
    var selectedImgData: Data!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        pickUpDate(txtBirthday)
    }
    
    
    func configureView() {
        
    }
    
    @IBAction func onTappedAvarta(_ sender: Any) {
        
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        imagePickerController.mediaTypes = ["public.image"]
        present(imagePickerController, animated: true, completion: nil)
        
    }
    
    
    func pickUpDate(_ textField : UITextField){
        // DatePicker
        self.datePicker = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.datePicker.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        self.datePicker.datePickerMode = UIDatePicker.Mode.date
        textField.inputView = self.datePicker
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 12.0 / 255, green: 211.0 / 255, blue: 214.0 / 255, alpha: 1)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        let date = Date()//df.date(from: dateString)
        self.datePicker.setDate(date, animated: true)
    }
    @objc func doneClick() {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "dd/MM/yyyy"
        txtBirthday.text = dateFormatter1.string(from: datePicker.date)
        txtBirthday.resignFirstResponder()
    }
    
    @objc func cancelClick() {
        txtBirthday.resignFirstResponder()
        txtBirthday.text = ""
    }
    
    @IBAction func onTappedSignUp(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SignUpNextViewController") as! SignUpNextViewController
        vc.photo = selectedImgData
        vc.FirstName = txtFirstName.text!
        vc.LastName = txtLastName.text!
        vc.UserName = txtUserName.text!
        vc.Email = txtEmail.text!
        vc.Birthday = txtBirthday.text!
        
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func onTappedBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
//    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
//
//        let scale = newWidth / image.size.width
//        let newHeight = image.size.height * scale
//   //     UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight))
//        image.draw(in: CGRectMake(0, 0, newWidth, newHeight))
//        let newImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//
//        return newImage!
//    }
    
    func resizeimage(image:UIImage,withSize:CGSize) -> UIImage {
        var actualHeight:CGFloat = image.size.height
        var actualWidth:CGFloat = image.size.width
        let maxHeight:CGFloat = withSize.height
        let maxWidth:CGFloat = withSize.width
        var imgRatio:CGFloat = actualWidth/actualHeight
        let maxRatio:CGFloat = maxWidth/maxHeight
        if (actualHeight>maxHeight||actualWidth>maxWidth) {
            if (imgRatio<maxRatio){
                //adjust width according to maxHeight
                imgRatio = maxHeight/actualHeight
                actualWidth = imgRatio * actualWidth
                actualHeight = maxHeight
            }else if(imgRatio>maxRatio){
                // adjust height according to maxWidth
                imgRatio = maxWidth/actualWidth
                actualHeight = imgRatio * actualHeight
                actualWidth = maxWidth
            }else{
                actualHeight = maxHeight
                actualWidth = maxWidth
            }
        }
        let rec:CGRect = CGRect(x:0.0,y:0.0,width:actualWidth,height:actualHeight)
        UIGraphicsBeginImageContext(rec.size)
        image.draw(in: rec)
        let image:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        let imageData = image.pngData()
        UIGraphicsEndImageContext()
        let resizedimage = UIImage(data: imageData!)
        return resizedimage!
    }
    
    
}

extension SignUpViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[.originalImage] as! UIImage
        imagePickerController.dismiss(animated: true, completion: nil)
        
        let cropViewController = CropViewController(image: image)
        cropViewController.delegate = self
        present(cropViewController, animated: true, completion: nil)
    }
}
extension SignUpViewController : CropViewControllerDelegate {
    func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        cropViewController.dismiss(animated: true, completion: nil)
        //        img = image
        
        let newImage : UIImage = resizeimage(image: image, withSize: CGSize(width:200, height: 200))
        
        selectedImgData = newImage.pngData()//image.jpegData(compressionQuality: 1)
        imgProfileAvarta.image = image
      //  imgProfileAvarta.setBackgroundImage(image, for: .normal)
    }
    
    func cropViewController(_ cropViewController: CropViewController, didFinishCancelled cancelled: Bool) {
        cropViewController.dismiss(animated: true, completion: nil)
    }
    
    
}

