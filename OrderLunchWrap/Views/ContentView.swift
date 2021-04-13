//
//  ContentView.swift
//  OrderLunchWrap
//
//  Created by Joshua Palgon on 12/6/20.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var order: Order
    var body: some View {
        NavigationView{

            VStack {
                Text("Welcome to LunchWraps, where you can mobile order Josh's Semi-Famous Lunch Wraps!").padding()
                Form{
                    TextField("Name", text: $order.name)
                    
                    Section(header: Text("Order here")){
                        
                        Picker(selection: $order.deliMeat,
                               label: Text("Deli"),
                               content: {
                                    Text("Turkey").tag(DeliMeat.turkey)
                                    Text("Turkey Pastrami").tag(DeliMeat.turkeyPastrami)
                                    Text("Ham").tag(DeliMeat.ham)
                        })
                        
                        //Should be new mack to select bool on each of toppings
                        NavigationLink(
                            destination: PickToppings(),
                            label: {
                                Text("Toppings")
                            })
                    
                    }
                    
                    TextField("Special Requests", text: $order.other)
                    
                    Section{
                        Button(action: {
                            do {
                                try order.submitOrder()
                            } catch {
                                print(error)
                            }
                        }, label: {
                            Text("Submit Order")
                        }).disabled(order.name == "")
                    }
                }.navigationTitle("LunchWraps")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(Order())
    }
}






