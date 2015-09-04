//
//  Bloom.swift
//  SwiftStructures
//
//  Created by Wayne Bishop on 9/2/15.
//  Copyright © 2015 Arbutus Software Inc. All rights reserved.
//

import Foundation

class Bloom {

    //initialize the filter
    private var bloomset: Array<Bool!>
    private var empty: Bool = true
    
    
    init(capacity: Int) {
        self.bloomset = Array<Bool!>(count: capacity, repeatedValue: nil)
    }


    
    //the number of set items
    var count: Int {
        return self.bloomset.count
    }

    
    //return set status
    var isEmpty: Bool {
        return empty
    }
    
    
    /*
     notes: As shown, the idea of "adding" elements to a bloom filter doesn't take place.
     Their goal is to test for the existence of membership in a specified set.
    */

    
    func addWord(element: String){
        
        
        //track positions with tuple
        var position: (first: Int, second: Int, third: Int)
        
        
        //establish position "spread"
        position.first = self.createhash(element)
        position.second = self.createhash(String(position.first))
        position.third = self.createhash((String(position.second)))
 
        
        //flip boolean values at designated position
        bloomset[position.first] = true
        bloomset[position.second] = true
        bloomset[position.third] = true

        
        self.empty = false
        
    }
    
    
    //check for membership
    func contains(element: String) -> Bool {
        
        
        //track positions with tuple
        var position: (first: Int, second: Int, third: Int)
        
        
        //establish position "spread"
        position.first = self.createhash(element)
        position.second = self.createhash(String(position.first))
        position.third = self.createhash((String(position.second)))
        

        //TODO: Change to swift 2.0 guard statement (with boolean optional..)?
        
        
        //determine if found in any position
        if bloomset[position.first] == nil {
            return false
        }
        
        else if bloomset[position.second] == nil {
            return false
        }
        
        else if bloomset[position.third] == nil {
            return false
            
        }

        //all tests passed
        else {
            return true
        }
        
        
    }

    

    
    //MARK: helper function..
    

    //hash algorithm - allocates the spread
    func createhash(element: String) -> Int! {
        
        var remainder: Int = 0
        var divisor: Int = 0

        
        /*
        note: modular math is used to calculate a hash value. The position count is used
        as the dividend to ensure all possible outcomes are between 0 and 25 . This is an example
        of a simple but effective hash algorithm.
        */
        
        
        for key in String(element).unicodeScalars {
            //print("the ascii value of \(key) is \(key.value)..")
            divisor += Int(key.value)
        }
        
        
        //zero-based index adjustment
        remainder = divisor % bloomset.count
        remainder -= 1

        
        return remainder
        
    }
    
    
    
}