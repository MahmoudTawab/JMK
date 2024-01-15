//
//  APIFunc.swift
//  APIFunc
//
//  Created by Emoji Technology on 27/09/2021.
//  Copyright © 2021 Mahmoud Tawab. All rights reserved.
//

import UIKit
import SDWebImage
import FirebaseStorage

    func PostAPI(api:String ,token:String?
                 , parameters:[String:Any]
                 ,string: @escaping ((String) -> Void)
                 , DictionaryData: @escaping (([String: Any]) -> Void)
                 , ArrayOfDictionary: @escaping (([[String: Any]]) -> Void)
                 , Err: @escaping ((String) -> Void)) {
        
        
    guard let Url = URL(string:api) else {return}
    var request = URLRequest(url: Url)
    request.httpMethod = "POST"
    request.timeoutInterval = 10
        
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "Accept")

    if let Token = token {
    request.setValue( "Bearer \(Token)", forHTTPHeaderField: "Authorization")
    }

    do {
    request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
    } catch let error {
    Err(error.localizedDescription)
    return
    }

    URLSession.shared.dataTask(with: request) { data, response, error in
    guard let data = data else {
    if let error = error {
    DispatchQueue.main.async {
    Err(StatusCodes(-1001, "\n" + error.localizedDescription))
    }
    }
    return
    }
       
    
    do {
    guard let response = response as? HTTPURLResponse else {return}
    if response.statusCode != 200 {
    if response.statusCode != 406 {
    DispatchQueue.main.async {
    Err(StatusCodes(response.statusCode))
    }
    }else{
    if response.statusCode == 406 {
    if let Array = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
    let Messag = Array["Messag"] as? String ?? "Sorry, unable to connect to the server"
    DispatchQueue.main.async {
    Err(StatusCodes(406, "ERROR MESSAG" + "\n" + Messag))
    }
    }
    }
    }
    return
    }
        
    if let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
    DispatchQueue.main.async {
    DictionaryData(dictionary)
    }
    }
        
    if let array = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
    DispatchQueue.main.async {
    ArrayOfDictionary(array)
    }
    }
      
    if let strContent = String(data: data, encoding: .utf8) {
    DispatchQueue.main.async {
    string(strContent)
    }
    }
        
    }catch{
    return
    }
    }.resume()
    }

  func StatusCodes(_ Status:Int ,_ Messag:String = "") -> String {

    switch Status {
       ///
    //    case 200 ..< 299:
    //    ShowMessageAlert(Alert,.success,"Successful Responses")
    //    return "Successful Responses"

        ///
    case 204:
    return "No Content"
        
       ///
    case 400:
    return "Bad Request"
       
       ///
    case 401:
    UpDateToken()
    return "Unauthorized"
       
    ///
    case 404:
    return "Not Found"
        
    ///
    case 406:
    return Messag
        
    ///
    case -1001:
    return Messag
       
    default:
    break
    }

    return ""
    }

    func UpDateToken() {
    var token : JWT?
    guard let url = defaults.string(forKey: "API") else{return}
    let api = "\(url + GetUsersToken)"
            
    LaunchScreen.LoadingSaveData(UserUpdate: nil, CartUpdate: nil){}
    guard let Email = LaunchScreen.User?.Email else{return}
    guard let Uid = LaunchScreen.User?.Uid else{return}
            
    let parameters:[String : Any] = ["AppId": "05c10698-8d71-4ea2-aee2-f00de9d68910",
                                    "Email": Email,
                                    "UID": Uid]
            
    PostAPI(api: api, token: nil, parameters: parameters) { _ in
    } DictionaryData: { data in
    token = JWT(dictionary: data)
    defaults.set(token?.Token, forKey: "JWT")
    defaults.synchronize()
    } ArrayOfDictionary: { _ in
    } Err: { error in
    print(error)
    }
    }

func ShowMessageAlert(_ IconTitle:String ,_ Title:String ,_ Message:String ,_ DoneisHidden:Bool ,_ selector: @escaping () -> Void,_ ButtonText:String = "Try Again") {

    if var topController = UIApplication.shared.keyWindow?.rootViewController  {
    while let presentedViewController = topController.presentedViewController {
    topController = presentedViewController
    }
    
    let Controller = PopUpCenterView()
    Controller.TitleText = Title
    Controller.IconTitle = IconTitle
    Controller.MessageText = Message
    Controller.TextDone = ButtonText
    Controller.DoneButton.isHidden = DoneisHidden

    Controller.DoneButton.addAction(for: .touchUpInside) { (button) in
    selector()
    }
    
    Controller.modalPresentationStyle = .overFullScreen
    Controller.modalTransitionStyle = .crossDissolve
    topController.present(Controller, animated: true, completion: nil)
    }
    }




    func StoragArray(child:[String] , image: [UIImage] , completionHandler: @escaping ((String) -> Void), Err: @escaping ((String) -> Void)) {
    for Image in image {
    guard let data = Image.jpegData(compressionQuality: 0.75) else {return}
    var storage = Storage.storage().reference().child(child[0]).child(child[1]).child("\(data)")
        
    let metaData = StorageMetadata()
    metaData.contentType = "image/jpg"
    storage.putData(data, metadata: metaData, completion: { (url, err) in
    if let err = err {
    Err(err.localizedDescription)
    return
    }
    storage.downloadURL {(url, err) in
    if let err = err {
    Err(err.localizedDescription)
    return
    }
    guard let add_downloadUrl = url?.absoluteString else{return}
    completionHandler(add_downloadUrl)
    }
    })
    }
    }

    func Storag(child:[String] , image: UIImage, completionHandler: @escaping ((String) -> Void), Err: @escaping ((String) -> Void)) {

    var storage = Storage.storage().reference().child(child[0]).child(child[1]).child(child[1])
    
    let metaData = StorageMetadata()
    metaData.contentType = "image/jpg"
    guard let data = image.jpegData(compressionQuality: 0.75) else {return}
    storage.putData(data, metadata: metaData, completion: { (url, err) in
    if let err = err {
    Err(err.localizedDescription)
    return
    }
    storage.downloadURL {(url, err) in
    if let err = err {
    Err(err.localizedDescription)
    return
    }
    guard let add_downloadUrl = url?.absoluteString else{return}
    completionHandler(add_downloadUrl)
    }
    })
    
        
    }


