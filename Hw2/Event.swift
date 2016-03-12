//
//  Event.swift
//  Hw2
//
//  Created by Dylan Homuth on 3/11/16.
//  Copyright © 2016 Dylan Homuth. All rights reserved.
//

import UIKit

class Event: NSObject, NSCoding  {
    //properties
    var name: String
    var discription: String
    var date: String

    //path
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("events")
    
    //types
    struct PropertyKey {
        
        
        static let nameKey = "name"
        static let discriptionKey = "discription"
        static let dateKey = "date"
        

    }
    
    init?(name: String, date: String, discription: String){
        self.name = name
        self.discription = discription
        self.date = date
        
        super.init()
        
        if name.isEmpty {
            return nil
        }
    }
    
    //NSCodeing
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(discription, forKey: PropertyKey.discriptionKey)
        aCoder.encodeObject(date, forKey: PropertyKey.dateKey)
    }
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let discription = aDecoder.decodeObjectForKey(PropertyKey.discriptionKey) as? String
        let date = aDecoder.decodeObjectForKey(PropertyKey.dateKey) as? String
        
        self.init(name: name, date: date!, discription: discription!)
    }
    


}
