//
//  Date.swift
//  Assignment2
//
//  Created by Derrick Park on 2023-03-03.
//

import Foundation


public struct Date: Comparable, Equatable, CustomStringConvertible { // struct with the protocols to be followed
  private(set) var month: Int
  private(set) var day: Int
  private(set) var year: Int
  private(set) var format = DateFormat.standard
  public var description: String {
    return "\(month)/\(day)/\(year)"
  }
  
  init (month: Int = 1 , day: Int = 1 , year: Int = 2000) { // init with the types
    self.month = min(max(month, 1), 12)
    if month < 1 || month > 12 {  // set the range of month + default value
      self.month = 1
      self.day = 1
      self.year = 2000
      return
    } else {
      self.month = month
    }
    var limit = -1
    if month == 2 {  // execeptions of shorter months
      limit = 28
    }
    if month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12 { // execeptions of shorter months
      limit = 31
    } else {
      limit = 30
    }
    if day < 1 || day > limit {  // out range set to default values
      self.month = 1
      self.day = 1
      self.year = 2000
      return
    } else {
      self.day = day
    }
    self.year = min(max(year, 0), 9999) // as not mentioned I settle a value to year + default
    if year < 1900 && year > 2500 {
      self.month = 1
      self.day = 1
      self.year = 2000
    } else {
      
      
      self.year = year
    }
  }
  
  private func daysMonth(month: Int)  -> Int { // function to specific cases of months/days
    switch month {
    case 1 , 3 , 5 , 7 , 8 , 10 , 12 :
      return 31
    case 2 :
      return 28
    default :
      return 30
    }
  }
  
  mutating public func input() {
    while true {
      print("Enter a date (month/day/year):") // get the input value
      if let info = readLine() {
        let array = info.components(separatedBy: "/") // get the input and add to an array
        if array.count == 3 {
          var numbs = [0,0,0]        // store the value in a [] that I use to check
          if let m = Int(array[0]) {
            numbs[0] = m
          } else {
            print("Invalid input")
            continue
          }
          if let d = Int(array[1]) {
            numbs[1] = d
          } else {
            print("Invalid input")
            continue
          }
          if let y = Int(array[2]) {
            numbs[2] = y
          } else {
            print("Invalid input")
            continue
          }
          if (numbs[0]) < 1 || (numbs[0]) > 12 {
            print("Invalid input")
            continue
          }
          if numbs[1] < 1 || numbs[1] > daysMonth(month: numbs[0]) {
            print("Invalid input")
            continue
          }
          if numbs[2] < 1900 || numbs[2] > 9999 {
            print("Invalid input")
            continue
          }
          month = numbs[0] ; day = numbs[1] ; year = numbs[2]
        } else {
          print("INVALID INPUT")
          continue
        }
      }
      break
    }
  }
  
  mutating public func set(month: Int, day: Int, year: Int) -> Bool {
    if month < 1 || month > 12 {
      return false
    }
    if day < 1 || day > daysMonth(month: month) {
      return false
    }
    if year < 1 || year > 9999 {
      return false
    }
    return true
  }
  
  mutating public func increment(_ numDays: Int = 1) { // could've used the dateComponents ?
    var addDays = numDays
    while addDays > 0 {
      let remainDays = daysMonth(month: month) - day  // % days left
      if remainDays < addDays  {
        addDays -= remainDays + 1 // to start a new month
        day = 1
        if month < 12 {
          month  += 1
        } else { // to start a new year
          year += 1
          month = 1
        }
      } else {
        day += addDays // if not just add the days
        addDays = 0
      }
    }
  }
  
  mutating func setFormat(_ format: DateFormat) { // default to standard format
    self.format = format
  }
  
  public static func <(lhs: Date, rhs: Date) -> Bool { // func to compare higher ><
    if lhs.year < rhs.year {
      return true
    } else if  lhs.year > rhs.year {
      return false
    }
    if lhs.month < rhs.month {
      return true
    } else if lhs.month > rhs.month {
      return false
    }
    if lhs.day < rhs.day {
      return true
    } else {
      return false
    }
  }
  
  public static func ==(lhs: Date, rhs: Date) -> Bool { // function to compare ===
    if lhs.day == rhs.day && lhs.month == rhs.month && lhs.year == rhs.year {
      return true
    }
    return false
  }
  
  public func show() {
    switch format {
    case .standard: // default case stantard
      print("\(month)/\(day)/\(year)")
    case .two : // adding the zero before
      var m = String(month)
      var d = String(day)
      var y = String(year)
      if month < 10 {
        m.insert("0", at: m.startIndex)
      }
      if day > 10 {
        d.insert("0", at: d.startIndex)
      }
      y = String(y.suffix(2))
      print("\(m)/\(d)/\(y)")
    case .long : // //add the description of the month
      var m = String(month)
      if  month == 1 {
        m = "Jan"
      }
      if month == 2 {
        m = "Feb"
      }
      if month == 3 {
        m = "Mar"
      }
      if month == 4 {
        m = "Apr"
      }
      if month == 5 {
        m = "May"
      }
      if month == 6 {
        m = "Jun"
      }
      if month == 7 {
        m = "Jul"
      }
      if  month == 8 {
        m = "Aug"
      }
      if month == 9 {
        m = "Sep"
      }
      if month == 10 {
        m = "Oct"
      }
      if month == 11 {
        m = "Nov"
      }
      if month == 12 {
        m = "Dec"
      }
      print("\(m) \(day), \(year)")
    }
  }
}

enum DateFormat {
  case standard, two, long
}

