//
//  ContentView.swift
//  OrderLunchWrap
//
//  Created by Joshua Palgon on 12/6/20.
//

import SwiftUI
import MessageUI

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
                                try submitOrder(order: order)
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


enum DeliMeat: String, CaseIterable {
    case turkey
    case turkeyPastrami
    case ham
}

struct Topping: Identifiable, Hashable {
    var name: String
    var value: Bool
    var id = UUID()
    
    mutating func toggleValue(){
        self.value.toggle()
    }
}


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
}

func submitOrder(order: Order) throws {
    var toppings: String = ""
    print(order.name)
    print(order.deliMeat)
    for topping in order.toppings {
        if topping.value == true {
            toppings += "\(topping.name), "
        }
    }
    print(order.other)
    
    let orderString = "\(order.name) would like to order \(order.deliMeat) with \(toppings)"
    
    //SEND MESSAGE
    let sms: String = "sms:+16787879468&body=\(orderString)"
    let strURL: String = sms.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    UIApplication.shared.open(URL.init(string: strURL)!, options: [:], completionHandler: nil)
    
}

enum WrapError: Error {
    case smsNotAvailable
}


