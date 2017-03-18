
import CoreData
import Foundation
import FoundationKit

public extension NSManagedObject {
    
    public class func instance<T: NSManagedObject>(_ context:NSManagedObjectContext) -> T? {
        
        let className = T.shortClassName()
        
        var instance : T?
        
        if let entity = NSEntityDescription.entity(forEntityName: className, in:context) {
        
            instance = T(entity:entity, insertInto:context)
            
        }
        
        return instance
        
    }
    
    func addObject(_ value:NSManagedObject, key:String) {
        
        let items = mutableSetValue(forKey: key)
        
        items.add(value)
        
    }
    
    func removeObject(_ value:NSManagedObject, key:String) {
        
        let items = mutableSetValue(forKey: key)
        
        items.remove(value)
        
    }
    
    func save() {
        
        if let context = managedObjectContext , context.hasChanges {
            
            context.performAndWait {
                
                do {

                    try context.save()
                    
                } catch {}
                
                self.saveParentContext(context)
                
            }
        
        }
        
    }
    
    fileprivate func saveParentContext(_ context:NSManagedObjectContext) {
        
        if let parentContext = context.parent , parentContext.hasChanges {
            
            parentContext.perform {
                
                do {
                   
                    try parentContext.save()
                    
                } catch {}
                
            }
            
        }
        
    }

}
