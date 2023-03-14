//
//  main.swift
//  Assignment2
//
//  Created by Derrick Park on 2023-03-03.
//

import Foundation

var d1 = Date()            // January 1, 2000
var d2 = Date(month: 2, day: 30, year: 1992) // April 10, 1992

print(d1.year)     // this is okay
// d1.year = 2002  // this is not okay (compile-error!)
print(d2)

d1.show()
d2.show()

d1.input() // allow user to enter a date for d1
d1.show()  // date must be updated based on the input above

d1.setFormat(.long)  // change the format of d1 to long format
d1.show()            // show in long format
print("increment by 100...")
d1.increment(100)
d1.show()
print("increment by 365...")
d1.increment(365)
d1.show()

print (d1==d2)
// and so on... Add your own tests to fully test the functionalities.
