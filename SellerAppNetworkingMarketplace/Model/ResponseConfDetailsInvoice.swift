//
//  ResponseConfDetailsInvoice.swift
//  SellerAppNetworkingMarketplace
//
//  Created by Stephane Gardon on 30/08/18.
//  Copyright © 2018 Liverpool. All rights reserved.
//

import Foundation
import ObjectMapper

public class ResponseConfDetailsInvoice:Mappable{
    
    public var cdis         :[ItemDico]?
    public var countries    :[ItemDico]?
    
    public required init?(map: Map){
    }
    
    public func mapping(map: Map){
        cdis <- map["cdis"]
        countries <- map["paises"]
    }
}

public class ItemDico:Mappable{
    public var position     :Int?
    public var value        :String?
    
    public required init?(map: Map){
    }
    
    public func mapping(map: Map){
        position <- map["position"]
        value <- map["value"]
    }
}
