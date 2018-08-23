//
//  BackendUrlManager.swift
//  SellerAppNetworkingMarketplace
//
//  Created by HAROJASD on 22/08/18.
//  Copyright © 2018 Liverpool. All rights reserved.
//

import Foundation


class BackendUrlManager : NSObject{
    
    enum ServiceUrlsId : Int {
        case createOrderMirakl
    }
    
    fileprivate static let SERVICE_CONTEXT:[String] = [
        "Middleware/rest/service/endeca-home?",                                 //createOrderMirkl
    ]
    
    // The array of all the services url's.
    fileprivate var serviceUrls:[String] = [String]();
    
    fileprivate func createUrls() {
        let servicesCount = BackendUrlManager.SERVICE_CONTEXT.count
        for index in 0..<servicesCount {
            //let nextUrl:String = "\(backendProtocol)\(backendHost)\(BackendUrlManager.SERVICE_CONTEXT[index])";
            let nextUrl:String = MarketplaceConnection.sharedInstance.baseURLString + "/" + BackendUrlManager.SERVICE_CONTEXT[index]
            serviceUrls.append(nextUrl)
        }
    }
    
    // Updating the URLs with the new middleware IP assigned in the Middleware Connection Singleton
    func updateUrls() {
        if !serviceUrls.isEmpty {
            serviceUrls.removeAll()
        }
        createUrls()
    }
    
    // Gets the indicated service url.
    func getUrl(_ urlId:ServiceUrlsId) -> String {
        let selectedUrl:String = serviceUrls[urlId.rawValue]
        return selectedUrl
    }
    
    // Private init to avoid several instances of this class.
    fileprivate override init() {
        super.init()
        self.createUrls()
    }
    
    // Singleton intance.
    static let Current:BackendUrlManager = BackendUrlManager()
    
}

