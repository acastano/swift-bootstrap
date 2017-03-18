
import Foundation
import FoundationKit

final class ResponseQueue: NSObject {
    
    fileprivate let queue = OperationQueue()
    
    class var instance: ResponseQueue {
        
        struct Static {
            
            static let instance = ResponseQueue()
            
        }
        
        return Static.instance
        
    }
    
    override init() {
        
        queue.maxConcurrentOperationCount = 1
        
        super.init()
        
    }
    
    class func addOperation(_ completion: @escaping VoidCompletion) {
        
        let operation = BlockOperation(block: completion)
        
        if let lastOperation = instance.queue.operations.last {
            
            operation.addDependency(lastOperation)
            
            operation.queuePriority = .normal
            
        } else {
            
            operation.queuePriority = .high
            
        }
        
        instance.queue.addOperation(operation)
        
    }
    
}
