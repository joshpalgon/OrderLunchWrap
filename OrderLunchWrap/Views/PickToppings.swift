//
//  PickToppings.swift
//  OrderLunchWrap
//
//  Created by Joshua Palgon on 12/6/20.
//

import SwiftUI

struct PickToppings: View {
    @EnvironmentObject var order: Order
    @State private var none: Bool = true
    var body: some View {
        Form{
            Button(action: {
                none.toggle()
                for index in 0 ..< order.toppings.count {
                    order.toppings[index].value = false
                }
            }, label: {
                HStack{
                    Text("None")
                    Spacer()
                    Image(systemName: none ? "checkmark.square" : "square")
                }.foregroundColor(Color.black)
            })

            ForEach(0 ..< order.toppings.count) { topping in
                Button (action: {
                    none = false
                    order.toppings[topping].toggleValue()
                }, label: {
                    HStack{
                        Text(order.toppings[topping].name)
                        Spacer()
                        Image(systemName: order.toppings[topping].value ? "checkmark.square" : "square")
                    }.foregroundColor(Color.black)
                    
                })
            }
            
        }.navigationBarTitle(Text("Toppings"))
    }
}

struct PickToppings_Previews: PreviewProvider {
    static var previews: some View {
        PickToppings().environmentObject(Order())
    }
}
