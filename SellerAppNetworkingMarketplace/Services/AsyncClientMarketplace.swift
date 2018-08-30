//
//  AsyncClientMarketplace.swift
//  SellerAppNetworkingMarketplace
//
//  Created by HAROJASD on 22/08/18.
//  Copyright © 2018 Liverpool. All rights reserved.
//

import Foundation
import AlamofireObjectMapper
import Alamofire
import ObjectMapper

public typealias ErrorStringHandler = (_ errorString:String) -> Void


public class AsyncClientMarketplace{
    /************** Petición GET **********************/
    class func getRequestExecute<T:Mappable>(_ type:BackendUrlManager.ServiceUrlsId, completion:@escaping (_ dataResponse:T) -> Void, errorCompletition: @escaping (_ errorString:String) -> Void){
        
        let url = BackendUrlManager.Current.getUrl(type)
        
        Alamofire.request(url, method: .get).responseObject { (response: DataResponse<T>) in
            
            if response.result.isSuccess{
                let responseService = response.result.value
                completion(responseService!)
            } else {
                errorCompletition((response.result.error?.localizedDescription)!)
            }
        }
    }
    /************** Petición POST **********************/
    class func postRequestExecuteWithTimeOut<T:Mappable>(_ _Type:BackendUrlManager.ServiceUrlsId, _Parameters: Parameters, _ViewLoader:Bool, _MsjLoader: String,_Completion:@escaping (_ _postRequest: T) -> Void, _ErrorCompletition: @escaping (_ errorString:String) -> Void){
        
        let url:URL! = URL(string: BackendUrlManager.Current.getUrl(_Type))
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 300 // 10 secs
        //let values = ["key": "value"]
        request.httpBody = try! JSONSerialization.data(withJSONObject: _Parameters, options: [])
        
        Alamofire.request(request).responseObject { (response: DataResponse<T>) in
            
            if response.result.isSuccess{
                let responseService = response.result.value
                _Completion(responseService!)
                
            }else{
                _ErrorCompletition((response.result.error?.localizedDescription)!)
            }
        }
    }

    
    /************** Petición POST Serializa un objeto JSON**********************/
    
    class func postRequestExecute<T:Mappable>(_ _Type:BackendUrlManager.ServiceUrlsId, _Parameters: Parameters!, _Completion:@escaping (_ _postRequest: T) -> Void, _ErrorCompletition: @escaping (_ errorString:String) -> Void)
    {
        let url = URL(string: BackendUrlManager.Current.getUrl(_Type))
        let request = NSMutableURLRequest(url: url!)
        
        request.httpMethod = "POST"
        request.httpBody = try! JSONSerialization.data(withJSONObject: _Parameters, options: [])
        
        
        Alamofire.request(url!, method: .post, parameters: _Parameters, encoding: JSONEncoding.default).responseObject { (response: DataResponse<T>) in
            
            if response.result.isSuccess{
                let responseService = response.result.value
                _Completion(responseService!)
            }else{
                _ErrorCompletition((response.result.error?.localizedDescription)!)
            }
        }
    }
    
    
    /************** Petición PUT **********************/
    class func putRequestExecute<T:Mappable>(_ _Type:BackendUrlManager.ServiceUrlsId, _Parameters: Parameters, _ViewLoader:Bool, _MsjLoader: String,_Completion:@escaping (_ putRequest: T) -> Void, _ErrorCompletition: @escaping (_ errorString:String) -> Void){
        
        
        let _Url = BackendUrlManager.Current.getUrl(_Type)
        Alamofire.request(_Url, method: .put, parameters: _Parameters, encoding: URLEncoding.default).responseObject { (response: DataResponse<T>) in
            
            if response.result.isSuccess{
                let responseService = response.result.value
                _Completion(responseService!)
                
            }else{
                _ErrorCompletition((response.result.error?.localizedDescription)!)
            }
        }
    }
    
    /**********************************PETICION DELETE***********************************/
    
    class func deleteRequestExecute<T:Mappable>(_ _Type:BackendUrlManager.ServiceUrlsId, _Parameters: Parameters!, _Completion:@escaping (_ _postRequest: T) -> Void, _ErrorCompletition: @escaping (_ errorString:String) -> Void)
    {
        let url = URL(string: BackendUrlManager.Current.getUrl(_Type))
        
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        Alamofire.request(url!, method: .delete, parameters: _Parameters, encoding: URLEncoding.default, headers: headers).responseObject { (response: DataResponse<T>) in
            
            if response.result.isSuccess{
                let responseService = response.result.value
                _Completion(responseService!)
            }else{
                _ErrorCompletition((response.result.error?.localizedDescription)!)
                
            }
        }
    }
    
    class func showSimpleAlert(_ title: String, message: String, viewController:UIViewController){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        viewController.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Facturacion
    class public func  getFacturacionDico(
        completion:@escaping (_ dataResponse: [ItemDico]? )-> Void,
        completionError: @escaping ErrorStringHandler )
    {
        AsyncClientMarketplace.getRequestExecute(
            BackendUrlManager.ServiceUrlsId.getConfigurationDetailsInvoice,
            completion: { (Response : ResponseConfDetailsInvoice) in
                completion(Response.countries) })
        { (msg) in
            completionError(msg)
        }
    }
    
}
