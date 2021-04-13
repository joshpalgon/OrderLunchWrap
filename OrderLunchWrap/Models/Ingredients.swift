//
//  Topping.swift
//  OrderLunchWrap
//
//  Created by Joshua Palgon on 4/13/21.
//

import Foundation

struct Topping: Identifiable, Hashable {
    var name: String
    var value: Bool
    var id = UUID()
    
    mutating func toggleValue(){
        self.value.toggle()
    }
}

enum DeliMeat: String, CaseIterable {
    case turkey
    case turkeyPastrami
    case ham
}
