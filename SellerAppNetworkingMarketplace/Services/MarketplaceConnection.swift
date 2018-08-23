//
//  MarketplaceConnection.swift
//  SellerAppNetworkingMarketplace
//
//  Created by HAROJASD on 22/08/18.
//  Copyright © 2018 Liverpool. All rights reserved.
//

import Foundation

public class MarketplaceConnection{
    private init(){}
    
    public static let sharedInstance:MarketplaceConnection = MarketplaceConnection()
    
    public var baseURLString:String = "" {
        didSet {
            // Updating the URLs with the new middleware IP assigned in the Middleware Connection Singleton
            BackendUrlManager.Current.updateUrls()
        }
    }
    
}
