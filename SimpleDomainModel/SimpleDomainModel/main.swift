//
//  main.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import Foundation

print("Hello, World!")

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
  
    
    
  public func convert(_ to: String) -> Money {
    if(currency == "USD") {
        switch to {
            case "USD":
                return Money(amount: amount, currency: currency)
            case "GBP":
                return Money(amount: amount / 2, currency: to)
            case "EUR":
                return Money(amount: 3 * amount / 2, currency: to)
            case "CAN":
                return Money(amount: 5 * amount * 4, currency: to)
            default:
                print("Invalid Currency \(to). Valid Currencies: USD, GBP, EUR, CAN")
                break
        }
    } else if(currency == "GBP") {
        return Money(amount: amount * 2, currency: "USD").convert(to)
    } else if(currency == "EUR") {
        return Money(amount: amount * 2/3, currency: "USD").convert(to)
    } else if(currency == "CAN") {
        return Money(amount: amount * 4/5, currency: "USD").convert(to)
    } else {
        print("Something went wrong.")
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
  }
  
  open func calculateIncome(_ hours: Int) -> Int {
  }
  
  open func raise(_ amt : Double) {
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
    get { }
    set(value) {
    }
  }
  
  fileprivate var _spouse : Person? = nil
  open var spouse : Person? {
    get { }
    set(value) {
    }
  }
  
  public init(firstName : String, lastName: String, age : Int) {
    self.firstName = firstName
    self.lastName = lastName
    self.age = age
  }
  
  open func toString() -> String {
  }
}

////////////////////////////////////
// Family
//
open class Family {
  fileprivate var members : [Person] = []
  
  public init(spouse1: Person, spouse2: Person) {
  }
  
  open func haveChild(_ child: Person) -> Bool {
  }
  
  open func householdIncome() -> Int {
  }
}





