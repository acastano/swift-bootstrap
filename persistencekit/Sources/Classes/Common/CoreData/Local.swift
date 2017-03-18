
import CoreData

open class Local: NSObject {
    
    fileprivate var type: String?
    fileprivate var bundle = Bundle.main
    
    fileprivate class var local: Local {
        
        struct Static {
            
            static let instance = Local()
            
        }
        
        return Static.instance
        
    }
    
    //MARK: - Helpers
    
    fileprivate func localType() -> String? {
        
        var type: String?
        
        if let config = bundle.object(forInfoDictionaryKey: LocalConfiguration.name.rawValue) as? [String:AnyObject] {
            
            type = config[LocalConfiguration.type.rawValue] as? String
            
        }
        
        return type
        
    }
    
    class func entities() -> [NSEntityDescription] {
        
        return local.managedObjectModel.entities
        
    }
    
    //MARK: - Context
    
    open class func mainContext() -> NSManagedObjectContext {
        
        let context = local.managedObjectContext
        
        return context
        
    }
    
    open class func setup(_ bundle:Bundle) {
        
        local.bundle = bundle
        
        local.type = local.localType()
        
    }
    
    //MARK: - Creation
    
    fileprivate func loadBundleDatabaseFromURL(_ documentsURL:URL) {
        
        if FileManager.default.fileExists(atPath: documentsURL.absoluteString) == false, let bundleURL = bundle.url(forResource: LocalConfiguration.db.rawValue, withExtension: nil) {
            
            do {
                
                try FileManager.default.moveItem(at: bundleURL, to: documentsURL)
                
            } catch {}
            
        }
        
    }
    
    lazy var applicationDocumentsDirectory: URL? = {
        
        let urls = FileManager.default.urls(for: .documentDirectory, in:.userDomainMask)
        
        return urls[urls.count - 1]
        
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        
        let coordinator = local.type == LocalType.InMemory.rawValue ? self.persistentStoreInMemoryCoordinator : self.persistentStoreCoordinator
        
        let managedObjectContext = NSManagedObjectContext(concurrencyType:.mainQueueConcurrencyType)
        
        managedObjectContext.undoManager = nil
        
        managedObjectContext.persistentStoreCoordinator = coordinator
        
        return managedObjectContext
        
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        
        objc_sync_enter(self)

        let coordinator = NSPersistentStoreCoordinator(managedObjectModel:self.managedObjectModel)
        
        if let url = self.applicationDocumentsDirectory?.appendingPathComponent(LocalConfiguration.db.rawValue) {
            
            self.loadBundleDatabaseFromURL(url)
            
            let options = [NSMigratePersistentStoresAutomaticallyOption:true, NSInferMappingModelAutomaticallyOption:true]
            
            do {
                
                try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName:nil, at:url, options:options)
                
            } catch {
                
                do {
                    
                    try FileManager.default.removeItem(at: url)
                    
                    self.loadBundleDatabaseFromURL(url)
                    
                    try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName:nil, at:url, options:options)
                    
                } catch {}
                
            }
            
        }
        
        objc_sync_exit(self)

        return coordinator
        
    }()
    
    lazy var persistentStoreInMemoryCoordinator: NSPersistentStoreCoordinator = {
        
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel:self.managedObjectModel)
        
        do {
            
            try coordinator.addPersistentStore(ofType: NSInMemoryStoreType, configurationName:nil, at:nil, options:nil)
            
        } catch {}
        
        return coordinator
        
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        
        var objectModel: NSManagedObjectModel?
        
        if let modelURL = local.bundle.url(forResource: LocalConfiguration.model.rawValue, withExtension:nil) {
                        
            objectModel = NSManagedObjectModel(contentsOf:modelURL)
            
        }
        
        return objectModel!
        
    }()
    
}
