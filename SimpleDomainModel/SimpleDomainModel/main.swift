//
//  main.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import Foundation

print("Hello, World")

public func testMe() -> String {
  return "I have been tested"
}

open class TestMe {
  open func Please() -> String {
    return "I have been tested"
  }
}

////////////////////////////////////
// Money
//
public struct Money {
    /*Acceptable currencies:
     1 USD = .5 GBP / 2 USD = 1 GBP
     
     1 USD = 1.5 EUR / 2 USD = 3 EUR
     
     1 USD = 1.25 CAN / 4 USD = 5 CAN
     */
  public var amount : Int
  public var currency : String
  
  /*public init?(amount : Int, currency: String) {
        if(currency = "USD" || currency = "GBP" || currency = "EUR" || currency = "CAN") {
            return nil
        }
        self.currency = currency
        self.amount = amount
    }*/
    
  public func convert(_ to: String) -> Money {
    if(currency == "USD") {
        switch to {
            case "USD":
                return self
            case "GBP":
                return Money(amount: amount / 2, currency: to)
            case "EUR":
                return Money(amount: 3 * amount / 2, currency: to)
            case "CAN":
                return Money(amount: 5 * amount * 4, currency: to)
            default:
                print("Invalid Currency \(to). Valid Currencies: USD, GBP, EUR, CAN")
                return self
        }
    } else if(currency == "GBP") {
        return (Money(amount: amount * 2, currency: "USD").convert(to))
    } else if(currency == "EUR") {
        return (Money(amount: amount * 2/3, currency: "USD").convert(to))
    } else if(currency == "CAN") {
        return (Money(amount: amount * 4/5, currency: "USD").convert(to))
    } else {
        print(print("Invalid Currency \(currency). Valid Currencies: USD, GBP, EUR, CAN"))
    }
    return self
  }
  
    /*
    * Adds the amount of two Money objects. If the money currencies objects are not equal,
    * converts the second object into the currency of the first object. Returns a Money
    * object of the result.
    * to (Money) - A Money object containing the currency to be added.
    */
  public func add(_ to: Money) -> Money {
    if(to.currency == currency) {
        return Money(amount: amount+to.amount, currency: currency)
    }
    return Money(amount: amount - to.convert(currency).amount, currency: currency)
  }
    
    /*
     * Subtracts the amount of to from the Money object. If the money currencies objects are
     * not equal,
     * converts the second object into the currency of the first object. Returns a Money
     * object of the result.
     * from (Money) - A Money object containing the currency to be used to subtract.
     */
  public func subtract(_ from: Money) -> Money {
    if(from.currency == currency) {
        return Money(amount: amount - from.amount, currency: currency)
    }
    return Money(amount: amount - from.convert(currency).amount, currency: currency)
  }
}

////////////////////////////////////
// Job
//
open class Job {
  fileprivate var title : String
  fileprivate var type : JobType

  public enum JobType {
    case Hourly(Double)
    case Salary(Int)
  }
  
  public init(title : String, type : JobType) {
    self.title = title
    self.type = type
  }
  
  open func calculateIncome(_ hours: Int) -> Int {
    switch type {
    case .Hourly (let wage):
        return Int(wage * Double(hours) / 2000.0)
    case .Salary (let wage):
        return wage
    }
  }
  
  open func raise(_ amt : Double) {
    switch type {
    case .Hourly (var wage):
        wage += amt
    case .Salary (var wage):
        wage += Int(amt)
    }
  }
}

////////////////////////////////////
// Person
//
open class Person {
  open var firstName : String = ""
  open var lastName : String = ""
  open var age : Int = 0

  fileprivate var _job : Job? = nil
  open var job : Job? {
    get {
        return _job
    }
    set(value) {
        _job = value
    }
  }
    
  fileprivate var _spouse : Person? = nil
  open var spouse : Person? {
    get {
         return _spouse
    }
    set(value) {
        _spouse = value
    }
  }
  
  public init(firstName : String, lastName: String, age : Int) {
    self.firstName = firstName
    self.lastName = lastName
    self.age = age
  }
  let base = "Single"
  open func toString() -> String {
    return "[Person: firstName: \(firstName) lastName: \(lastName) age: \(age) Salary(\(job?.calculateIncome(2000) ?? 0)) Spouse: \(spouse?.firstName ?? base)]"
  }
}

////////////////////////////////////
// Family
//
open class Family {
  fileprivate var members : [Person] = []
  
  public init(spouse1: Person, spouse2: Person) {
    spouse1.spouse = nil;
    spouse2.spouse = nil;
    spouse1.spouse = spouse2
    spouse2.spouse = spouse1
    members.append(spouse1)
    members.append(spouse2)
    
    
  }
  
  open func haveChild(_ child: Person) -> Bool {
    if(members[0].age >= 21 || members[2].spouse?.age ?? 20 >= 21) {
        members.append(child);
        return true
    }
    return false
  }
  
  open func householdIncome() -> Int {
    var totalIncome = 0
    for mem in members {
        totalIncome += mem.job?.calculateIncome(2000) ?? 0
    }
    return totalIncome
  }
}





