//
//  ApiService.swift
//  DigiiKitchen
//
//  Created by Admin on 3/15/19.
//  Copyright © 2019 SnowMan. All rights reserved.
//

import Foundation
import Alamofire
import KVNProgress
class  ApiService{
    static let shared = ApiService()
    private init(){}
    
    func loginUser(body:[String: Any]?, completion: @escaping(Error?, Any?)->()) {
        let headers = [
            "Authorization": "Bearer none",
            ]
        
        let url = Constants.USER_LOGIN
        
        Alamofire.request(url, method: .post, parameters: body, encoding: URLEncoding.default, headers : headers).responseJSON { response in
            
            switch response.result {
            case .success(let JSON):
                completion(nil, JSON)
             //   KVNProgress.showError(withStatus: "response received")
            case .failure(let error):
                completion(error, nil)
                KVNProgress.showError(withStatus: error.localizedDescription)
            }
        }
        
    }
  
    
    public func registerUser(file: URL,parameters: [String : Any], completion: @escaping (Error?, Any?)->Void) {
        let url = Constants.REGISTER_USER
        self.uploadRequest(url: url, file: file, body : parameters, completion: {
            error, result in
            completion(error, result)
        })
    }
    
    public func uploadRequest(url: String, file: URL, body: [String: Any]? = nil, completion: @escaping (Error?, Any?)->()) {
       
        Alamofire.upload(multipartFormData: {
            multipartFormData in
            if body != nil {
//                let data = try! JSONSerialization.data(withJSONObject: body!)
                
                for (key, value) in body! {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }

//                multipartFormData.append(data, withName: "post")
            }
            
            multipartFormData.append(file, withName: "photo", fileName: "avatar.png", mimeType: "image/png")
        }, to: url,
            method: .post,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.uploadProgress(closure: { (progress) in
                        print("Upload Progress: \(progress.fractionCompleted)")
                    })
                    upload.responseJSON(completionHandler: {
                        response in
                        switch response.result {
                        case .success(let JSON):
                            completion(nil, JSON)
                        case .failure(let error):
                            completion(error, nil)
                            KVNProgress.showError(withStatus: error.localizedDescription)
                        }
                    })
                case .failure(let error):
                    completion(error, nil)
                }
        })
        
    }
    
    public func getCategoryList(body:[String: Any]?, completion: @escaping(Error?, Any?)->()) {
    let headers = [
    "Authorization": "Bearer none",
    ]
    
    let url = Constants.GET_CATEGORYLIST
    Alamofire.request(url, method: .post, parameters: body, encoding: URLEncoding.default, headers : headers).responseJSON { response in
        
        
        switch response.result {
            case .success(let JSON):
            completion(nil, JSON)
            //   KVNProgress.showError(withStatus: "response received")
            case .failure(let error):
            completion(error, nil)
            KVNProgress.showError(withStatus: error.localizedDescription)
            }
        }
    
    }
    
    public func getProductList(body:[String: Any]?, completion: @escaping(Error?, Any?)->()) {
        let headers = [
            "Authorization": "Bearer none",
            ]
        
        let url = Constants.GET_PRODUCT_LIST
        Alamofire.request(url, method: .post, parameters: body, encoding: URLEncoding.default, headers : headers).responseJSON { response in
        
            switch response.result {
            case .success(let JSON):
                completion(nil, JSON)
            //   KVNProgress.showError(withStatus: "response received")
            case .failure(let error):
                completion(error, nil)
                KVNProgress.showError(withStatus: error.localizedDescription)
            }
        }
        
    }
    
    public func get_country_list(body:[String: Any]?, completion: @escaping(Error?, Any?)->()) {
    let headers = [
    "Authorization": "Bearer none",
    ]
    
    let url = Constants.GET_COUNTRY_LIST
    Alamofire.request(url, method: .post, parameters: body, encoding: URLEncoding.default, headers : headers).responseJSON { response in
    
    switch response.result {
            case .success(let JSON):
            completion(nil, JSON)
            //   KVNProgress.showError(withStatus: "response received")
            case .failure(let error):
            completion(error, nil)
            KVNProgress.showError(withStatus: error.localizedDescription)
            }
        }
    
    }
    
    public func get_ingredient_category(body:[String: Any]?, completion: @escaping(Error?, Any?)->()) {
        let headers = [
            "Authorization": "Bearer none",
            ]
        
        let url = Constants.GET_INGREDIENT_CATEGORY
        Alamofire.request(url, method: .post, parameters: body, encoding: URLEncoding.default, headers : headers).responseJSON { response in
            
            switch response.result {
            case .success(let JSON):
                completion(nil, JSON)
            //   KVNProgress.showError(withStatus: "response received")
            case .failure(let error):
                completion(error, nil)
                KVNProgress.showError(withStatus: error.localizedDescription)
            }
        }
        
    }
    
    public func get_ingredient_list(body:[String: Any]?, completion: @escaping(Error?, Any?)->()) {
        let headers = [
            "Authorization": "Bearer none",
            ]
        
        let url = Constants.GET_INGREDIENTS
        Alamofire.request(url, method: .post, parameters: body, encoding: URLEncoding.default, headers : headers).responseJSON { response in
            
            switch response.result {
            case .success(let JSON):
                completion(nil, JSON)
            //   KVNProgress.showError(withStatus: "response received")
            case .failure(let error):
                completion(error, nil)
                KVNProgress.showError(withStatus: error.localizedDescription)
            }
        }
        
    }
    
    
    
    
    
}


