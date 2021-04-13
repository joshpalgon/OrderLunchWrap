//
//  Order.swift
//  OrderLunchWrap
//
//  Created by Joshua Palgon on 4/13/21.
//

import Foundation
import MessageUI
import SwiftUI

class Order: ObservableObject {
    @Published var name: String = ""
    @Published var deliMeat: DeliMeat = .turkey
    @Published var toppings: [Topping] = [
        Topping(name: "Spinach", value: false),
        Topping(name: "Onion", value: false),
        Topping(name: "Tomato", value: false),
        Topping(name: "Provolone", value: false),
        Topping(name: "Swiss", value: false),
        Topping(name: "Sriracha Mayo", value: false),
    ]
    @Published var other: String = ""
    
    func submitOrder() throws {
        var toppings: String = ""
        print(self.name)
        print(self.deliMeat)
        for topping in self.toppings {
            if topping.value == true {
                toppings += "\(topping.name), "
            }
        }
        print(self.other)
        
        let orderString = "\(self.name) would like to order \(self.deliMeat) with \(toppings)"
        
        //SEND MESSAGE
        let sms: String = "sms:+1\(""/*Phone number*/)&body=\(orderString)" //removed phone number
        let strURL: String = sms.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        DispatchQueue.main.async{
            UIApplication.shared.open(URL.init(string: strURL)!, options: [:], completionHandler: nil)
        }
    }
}
