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
        
        let url:URL! = URL(string: BackendUrlManager.Current.getUrl(type))
        
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
        
        
        let url = BackendUrlManager.Current.getUrl(type)
        Alamofire.request(url, method: .put,
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
    class public func getFacturacionDicoCountry(
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
    
    class public func getFacturacionDicoCfdi(
        completion      : @escaping (_ dataResponse: [ItemDico]? )-> Void,
        completionError : @escaping ErrorStringHandler )
    {
        AsyncClientMarketplace.getRequestExecute(
            BackendUrlManager.ServiceUrlsId.getConfigurationDetailsInvoice,
            completion: { (Response : ResponseConfDetailsInvoice) in
                completion(Response.cfdis) })
        { (msg) in
            completionError(msg)
        }
    }
    
    enum pageEnum : Int{
        case FisicalMoral = 0, Extranjero = 1, Acreditar = 2
        func value() -> String {
            switch (self) {
            case .FisicalMoral:return "Fisica/Moral"
            case .Extranjero:return "Extranjero"
            case .Acreditar:return "Acreditar"
            }}
    }
    
    class public func invoiceRequest(
        parameters      : [String: Any],
        completion      : @escaping (_ dataResponse: ResponseInvoiceRequest? )-> Void,
        completionError : @escaping ErrorStringHandler )
    {
        
        var params : [String: Any] = [:]
        let page : pageEnum = pageEnum(rawValue:
            ( parameters["invoiceType"] != nil ?
                parameters["invoiceType"] as! Int: 0))!
        
        let rfc =
            (page == .Extranjero) ||
                (page == .Acreditar &&
                    "\(parameters["tipoDePersona"] ?? "" )"  == "Moral") ?
                        "XEXX010101000" : parameters["invoiceRFC"] ?? ""
        var rfc1 = "",
        rfc2 = "",
        rfc3 = ""
        
        let rfcAll = String(describing: rfc)
        if rfcAll.count == 13{
            
            let start = rfcAll.index(rfcAll.startIndex, offsetBy: 4)
            let end = rfcAll.index(rfcAll.endIndex, offsetBy: -3)
            let range = start..<end
            
            rfc1 = String(rfcAll.prefix(4))
            rfc3 = String(rfcAll.suffix(3))
            rfc2 = String(rfcAll[range])
        }
        
        var cfdi : String = String(describing: (parameters["usoCFDI"] ?? ""))
        if cfdi != "" && cfdi.count >= 3{
            let cfdiSplit = cfdi.components(separatedBy: " - ")
            
            if cfdiSplit.count > 1 {
                
                cfdi = cfdiSplit[1]
                
                if cfdiSplit.count > 2{
                    for i in 2 ..< cfdiSplit.count{
                        cfdi += " - " + cfdiSplit[i]
                    }
                }
            }
        }
        
        var pais : String = String(describing: (parameters["country"] ?? ""))
        if pais != "" && pais.count >= 3{
            let split = pais.components(separatedBy: " - ")
            
            if split.count > 1 {
                
                pais = split[1]
                
                if split.count > 2{
                    for i in 2 ..< split.count{
                        pais += " - " + split[i]
                    }
                }
            }
        }
        
        params["page"]              = page.value() //"Fisica/Moral" or "Extranjero" or "Acreditar"
        params["trackingNumber"]    = parameters["trackingNumber"] ?? "8988998"
        params["rfc1"]              = rfc1 == "" ? rfc as! String : rfc1
        params["rfc2"]              = rfc2
        params["rfc3"]              = rfc3
        params["emailId"]           = parameters["invoiceEmail"] ?? ""
        params["usoCFDI"]           = cfdi //parameters["usoCFDI"] ?? ""
        params["country"]           = pais //parameters["country"] ?? ""
        params["taxRegistration"]   = parameters["invoiceNumRegIdTributaria"] ?? "" //"CPF"
        params["tipoDePersona"]     = parameters["tipoDePersona"] ?? "" //(“Fisica” or “Moral”)
        params["razonSocial"]       = parameters["razonSocial"] ?? ""
        params["name"]              = parameters["name"] ?? ""
        params["paternalName"]      = parameters["paternalName"] ?? ""
        params["maternalName"]      = parameters["maternalName"] ?? ""
        
        AsyncClientMarketplace.postRequestExecute(
            BackendUrlManager.ServiceUrlsId.invoiceRequest,
            parameters: params,
            completion: { (Response : ResponseInvoiceRequest) in
                if Response.errorDescription != nil{
                    completionError(Response.errorDescription!)
                }else{
                    completion(Response)
                }
        },
            errorCompletition: { (msg) in
                completionError(msg)
        })
    }
    
}


