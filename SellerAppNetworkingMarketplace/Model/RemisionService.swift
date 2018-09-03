//
//  RemisionService.swift
//  SellerAppNetworkingMarketplace
//
//  Created by Oscar Morales on 03/09/18.
//  Copyright © 2018 Liverpool. All rights reserved.
//

import Foundation

public class RemisionService
{
    class public func createMKPOrder(parameters: [String:Any], completion:@escaping (_ dataResponse: responseOrder)-> Void, completionError: @escaping ErrorStringHandler){
        
        AsyncClientMarketplace.postRequestExecute(
            BackendUrlManager.ServiceUrlsId.createOrderMirakl,
            parameters: parameters,
            completion: { (Response : responseOrder) in
                
        },
            errorCompletition: { (msg) in
                completionError(msg)
        })
        
    }
}
