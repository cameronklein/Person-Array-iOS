//
//  Person.swift
//  Person Array iOS
//
//  Created by Cameron Klein on 8/6/14.
//  Copyright (c) 2014 Cameron Klein. All rights reserved.
//

import Foundation
import UIKit

class Person{
    
    var firstName   : String
    var lastName    : String
    var image       : UIImage?
    
    init (firstName: String, lastName : String){
        self.firstName = firstName
        self.lastName = lastName
    }
    
    func fullName() -> String {
        return self.firstName + " " + self.lastName
    }
    
}