
import CoreData
import Foundation

public extension Local {
    
    //MARK: - Queries
    
    class func firstWithPredicate<T: NSFetchRequestResult>(_ predicate:NSPredicate?, sort:NSSortDescriptor?, entity:String, context:NSManagedObjectContext) -> T? {
        
        var object: T?
        
        let sorts: [NSSortDescriptor]? = sort != nil ? [sort!] : nil
        
        if let results: [T] = resultsWithPredicate(predicate, sorts:sorts, entity:entity, context:context) , results.count > 0 {
            
            object = results[0]
            
        }
        
        return object
        
    }
    
    class func resultsWithPredicate<T: NSFetchRequestResult>(_ predicate:NSPredicate?, sorts:[NSSortDescriptor]?, entity:String, context:NSManagedObjectContext) -> [T]? {
        
        let fetchRequest = NSFetchRequest<T>(entityName:entity)
        
        fetchRequest.predicate = predicate
        
        if let sorts = sorts {
            
            fetchRequest.sortDescriptors = sorts
            
        }
        
        let results: [T]?
        
        do {
            
            results = try context.fetch(fetchRequest)
            
        } catch {
            
            results = nil
            
        }
        
        return results
        
    }
    
    class func resultsWithPredicate(_ predicate:NSPredicate?, propertiesToFetch:[String], resultType:NSFetchRequestResultType, sort:NSSortDescriptor?, entity:String, context:NSManagedObjectContext) -> [Any]? {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
        
        fetchRequest.predicate = predicate
        
        fetchRequest.resultType = resultType
        
        fetchRequest.returnsDistinctResults = true
        
        fetchRequest.propertiesToFetch = propertiesToFetch
        
        if sort != nil {
            
            fetchRequest.sortDescriptors = [sort!]
            
        }
        
        let results: [Any]?
        
        do {
            
            results = try context.fetch(fetchRequest)
            
        } catch {
            
            results = nil
            
        }
        
        return results
        
    }
    
    class func fetchedResultsController<T: NSFetchRequestResult>(_ predicate:NSPredicate?, sorts:[NSSortDescriptor]?, fetchLimit:Int?, entity:String, section:String?) -> NSFetchedResultsController<T> {
        
        let fetchRequest = NSFetchRequest<T>(entityName:entity)
        
        fetchRequest.fetchBatchSize = 20
        
        if fetchLimit != nil {
            
            fetchRequest.fetchLimit = fetchLimit!
            
        }
        
        if predicate != nil {
            
            fetchRequest.predicate = predicate
            
        }
        
        if let sorts = sorts {
            
            fetchRequest.sortDescriptors = sorts
            
        }
        
        let context = mainContext()
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest:fetchRequest, managedObjectContext:context, sectionNameKeyPath:section, cacheName:nil)
        
        return fetchedResultsController
        
    }
    
    //MARK: Save
    
    class func saveMainContext() {
        
        let context = mainContext()
        
        saveContext(context)
        
    }
    
    class func saveContext(_ context:NSManagedObjectContext) {
        
        if context.hasChanges {
            
            context.performAndWait {
                
                do {
                    
                    try context.save()
                    
                } catch {}
                
                
                self.saveParentContext(context)
                
            }
            
        }
        
    }
    
    private class func saveParentContext(_ context:NSManagedObjectContext) {
        
        if let parentContext = context.parent, parentContext.hasChanges {
        
            parentContext.perform {
                
                do {
                    
                    try parentContext.save()
                    
                } catch {}
                
            }
            
        }
        
    }
    
    //MARK: - Delete
    
    class func deleteAll<T:NSFetchRequestResult>(entity:T.Type) where T: NSObject {
        
        let context = mainContext()
        
        deleteAll(entity: entity, predicate:nil, context:context)
        
    }
    
    
    class func deleteAll<T:NSFetchRequestResult>(entity:T.Type, predicate:NSPredicate?) where T: NSObject {
        
        let context = mainContext()
        
        deleteAll(entity: entity, predicate:predicate, context:context)
        
    }
    
    class func deleteAll<T:NSFetchRequestResult>(entity:T.Type, predicate:NSPredicate?, context:NSManagedObjectContext) where T: NSObject {
        
        if let results: [T] = resultsWithPredicate(predicate, sorts:nil, entity:entity.className(), context:context) {
            
            for object in results  {
                
                delete(object, context:context)
                
            }
            
        }
        
    }
    
    class func delete(_ object:NSFetchRequestResult, context:NSManagedObjectContext) {
        
        if let object = object as? NSManagedObject {
            
            context.delete(object)
            
        }
        
    }
    
    class func concurrentContext() -> NSManagedObjectContext {
        
        let context = NSManagedObjectContext(concurrencyType:.privateQueueConcurrencyType)
        
        context.parent = mainContext()
        
        context.undoManager = nil
        
        return context
        
    }
    
}
