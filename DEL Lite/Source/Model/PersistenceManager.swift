//
//  PersistenceManager.swift
//  DEL Lite
//
//  Created by 강동영 on 2022/10/19.
//

import UIKit
import CoreData

class PersistenceManager {
    var shared = PersistenceManager()
    
    private init() {}
    
    func fetch() -> [NSManagedObject] {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "BLEDevice")
        
        //let sort = NSSortDescriptor(key: "regdate", ascending: false)
        //fetchRequest.sortDescriptors = [sort]
        let result = try! context.fetch(fetchRequest)
        return result
    }
    
    func save(title: String) -> Bool {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let object = NSEntityDescription.insertNewObject(forEntityName: "BLEDevice",
                                                         into: context)
        
        object.setValue(title, forKey: "name")
        
        do {
            try context.save()
            return true
        } catch {
            context.rollback()
            return false
        }
    }
    
    func edit(object: NSManagedObject, title: String, contents: String) -> Bool {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let object = NSEntityDescription.insertNewObject(forEntityName: "BLEDevice",
                                                         into: context)
        
        object.setValue(title, forKey: "name")
        
        
        do {
            try context.save()
            //self.list = self.fetch()
            return true
        } catch {
            context.rollback()
            return false
        }
    }
    
    func delete(object: NSManagedObject) -> Bool {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        context.delete(object)
        
        do {
            try context.save()
            //self.list.append(object)
            return true
        } catch {
            context.rollback()
            return false
        }
    }
}
