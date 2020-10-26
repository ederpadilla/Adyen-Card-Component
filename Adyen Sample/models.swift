//
//  models.swift
//  Adyen Sample
//
//  Created by Eder  Padilla on 13/05/20.
//  Copyright © 2020 EderPadilla. All rights reserved.
//

import Foundation
import Adyen

struct AdyenPayments: Codable {
    let paymentMethods: [AdyenPaymentMethod]
    func asPaymentMethods() -> PaymentMethods? {
        do {
            let jsonData = try JSONEncoder().encode(self)
            
            return try JSONDecoder().decode(PaymentMethods.self, from: jsonData)
        } catch {
            return nil
        }
    }
}

struct AdyenPaymentMethod: Codable {
    let name: String
    let type: String
    let brands: [String]
    let details: [AdyenDetail]
    
    func asCardPaymentMethod() -> CardPaymentMethod? {
        do {
            let jsonData = try JSONEncoder().encode(self)
            
            return try JSONDecoder().decode(CardPaymentMethod.self, from: jsonData)
        } catch {
            return nil
        }
    }
}

struct AdyenDetail: Codable {
    let key: String
    let type: String
}
