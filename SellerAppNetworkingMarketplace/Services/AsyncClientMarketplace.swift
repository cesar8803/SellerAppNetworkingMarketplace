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
    class func getRequestExecute<T:Mappable>(
        _ type:BackendUrlManager.ServiceUrlsId,
        completion:@escaping (_ dataResponse:T) -> Void,
        errorCompletition: @escaping (_ errorString:String) -> Void){
        
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
    class func postRequestExecuteWithTimeOut<T:Mappable>(
        _ type:BackendUrlManager.ServiceUrlsId,
        parameters          : Parameters,
        viewLoader          : Bool,
        msjLoader           : String,
        completion          : @escaping (_ postRequest: T) -> Void,
        errorCompletition   : @escaping (_ errorString:String) -> Void){
        
        let url:URL! = URL(string: BackendUrlManager.Current.getUrl(type))
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 300 // 10 secs
        //let values = ["key": "value"]
        request.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        
        Alamofire.request(request).responseObject { (response: DataResponse<T>) in
            
            if response.result.isSuccess{
                let responseService = response.result.value
                completion(responseService!)
                
            }else{
                errorCompletition((response.result.error?.localizedDescription)!)
            }
        }
    }

    
    /************** Petición POST Serializa un objeto JSON**********************/
    
    class func postRequestExecute<T:Mappable>(
        _ type:BackendUrlManager.ServiceUrlsId,
        parameters: Parameters!,
        completion:@escaping (_ postRequest: T) -> Void,
        errorCompletition: @escaping (_ errorString:String) -> Void)
    {
        let url = URL(string: BackendUrlManager.Current.getUrl(type))
        let request = NSMutableURLRequest(url: url!)
        
        request.httpMethod = "POST"
        request.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        
        
        Alamofire.request(url!, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseObject { (response: DataResponse<T>) in
            
            if response.result.isSuccess{
                let responseService = response.result.value
                completion(responseService!)
            }else{
                errorCompletition((response.result.error?.localizedDescription)!)
            }
        }
    }
    
    
    /************** Petición PUT **********************/
    class func putRequestExecute<T:Mappable>(
        type:BackendUrlManager.ServiceUrlsId,
        parameters: Parameters,
        viewLoader:Bool,
        msjLoader: String,
        completion:@escaping (_ putRequest: T) -> Void,
        errorCompletition: @escaping (_ errorString:String) -> Void){
        
        
        let _Url = BackendUrlManager.Current.getUrl(type)
        Alamofire.request(_Url, method: .put,
                          parameters: parameters,
                          encoding: URLEncoding.default).responseObject { (response: DataResponse<T>) in
            
            if response.result.isSuccess{
                let responseService = response.result.value
                completion(responseService!)
                
            }else{
                errorCompletition((response.result.error?.localizedDescription)!)
            }
        }
    }
    
    /**********************************PETICION DELETE***********************************/
    
    class func deleteRequestExecute<T:Mappable>(
        type:BackendUrlManager.ServiceUrlsId,
        parameters: Parameters!,
        completion:@escaping (_ postRequest: T) -> Void,
        errorCompletition: @escaping (_ errorString:String) -> Void)
    {
        let url = URL(string: BackendUrlManager.Current.getUrl(type))
        
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        Alamofire.request(url!, method: .delete, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseObject { (response: DataResponse<T>) in
            
            if response.result.isSuccess{
                let responseService = response.result.value
                completion(responseService!)
            }else{
                errorCompletition((response.result.error?.localizedDescription)!)
                
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
    class public func getFacturacionDico(
        completion      : @escaping (_ dataResponse: [ItemDico]? )-> Void,
        completionError : @escaping ErrorStringHandler )
    {
        AsyncClientMarketplace.getRequestExecute(
            BackendUrlManager.ServiceUrlsId.getConfigurationDetailsInvoice,
            completion: { (Response : ResponseConfDetailsInvoice) in
                completion(Response.countries) })
        { (msg) in
            completionError(msg)
        }
    }
    
    class public func invoiceRequest(
        parameters      : [String: Any],
        completion      : @escaping (_ dataResponse: ResponseInvoiceRequest? )-> Void,
        completionError : @escaping ErrorStringHandler )
    {
        AsyncClientMarketplace.postRequestExecute(
            BackendUrlManager.ServiceUrlsId.invoiceRequest,
            parameters: parameters,
            completion: { (Response : ResponseConfDetailsInvoice) in
                
        },
            errorCompletition: { (msg) in
                completionError(msg)
        })
    }
    
}
