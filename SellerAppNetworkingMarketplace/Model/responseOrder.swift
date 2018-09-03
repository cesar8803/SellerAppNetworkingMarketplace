//
//  responseOrder.swift
//  SellerAppNetworkingMarketplace
//
//  Created by Oscar Morales on 03/09/18.
//  Copyright © 2018 Liverpool. All rights reserved.
//

import Foundation
import ObjectMapper

public class responseOrder: Mappable{
    public var offers_not_shippable: [Any]?
    public var error_code: String?
    public var offer_id: Int?
    public var orders: [Any]?
    public var acceptance_decision_date: String?
    public var can_cancel: Bool?
    public var can_evaluate: Bool?
    public var channel: String?                 //TODO: Cambiar por el objeto del tipo indicado
    public var code: String?
    public var label: String?
    public var commercial_id: String?
    public var created_date: String?
    public var currency_iso_code: String?
    public var customer: String?                //TODO: Cambiar por el objeto del tipo indicado
    public var billing_address: String?         //TODO: Cambiar por el objeto del tipo indicado
    public var city: String?
    public var civility: String?
    public var company: String?
    public var country: String?
    public var country_iso_code: String?
    public var firstname: String?
    
    public required init?( map: Map){
    }
    public func mapping(map: Map){
        offers_not_shippable <- map["offers_not_shippable"]
        error_code <- map["error_code"]
        offer_id <- map["offer_id"]
        orders <- map["orders"]
        acceptance_decision_date <- map["acceptance_decision_date"]
        can_cancel <- map["can_cancel"]
        can_evaluate <- map["can_evaluate"]
        channel <- map["channel"]
        code <- map["code"]
        label <- map["label"]
        commercial_id <- map["commercial_id"]
        created_date <- map["created_date"]
        currency_iso_code <- map["currency_iso_code"]
        customer <- map["customer"]
        billing_address <- map["billing_address"]
        city <- map["city"]
        civility <- map["civility"]
        company <- map["company"]
        country <- map["country"]
        country_iso_code <- map["country_iso_code"]
        firstname <- map["firstname"]
    }
}
