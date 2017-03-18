
import Foundation

public extension NSObject {
    
    public func runOnMainThread(_ completion:@escaping VoidCompletion) {
        
        DispatchQueue.main.async(execute: completion)
        
    }
    
    public func runInBackground(_ completion:@escaping VoidCompletion) {
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async(execute: completion)
        
    }

    public func runOnMainThreadAfter(_ seconds:Double, completion:@escaping VoidCompletion) {
      
        let delay = seconds * Double(NSEC_PER_SEC)
        
        let time = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        
        DispatchQueue.main.asyncAfter(deadline: time, execute: completion)
        
    }
    
    public class func runOnMainThread(_ completion:@escaping VoidCompletion) {
        
        DispatchQueue.main.async(execute: completion)
        
    }
    
    public class func runInBackground(_ completion:@escaping VoidCompletion) {
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async(execute: completion)
        
    }
    
    public class func runOnMainThreadAfter(_ seconds:Double, completion:@escaping VoidCompletion) {
        
        let delay = seconds * Double(NSEC_PER_SEC)
        
        let time = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        
        DispatchQueue.main.asyncAfter(deadline: time, execute: completion)
        
    }
    
    public class func runOnLowPriorityQueue(_ completion:@escaping VoidCompletion) {
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.utility).async(execute: completion)
        
    }

}

