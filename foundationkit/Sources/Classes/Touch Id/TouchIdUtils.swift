
import Foundation
import LocalAuthentication

public typealias TouchIdAttemptCompletion = (Bool, Error?) -> ()
public typealias TouchIdAvailabilityCompletion = (Bool, LAError?) -> ()

public class TouchIdUtils {
    
    public class func isAvailable(completion: TouchIdAvailabilityCompletion) {
        
        let context = LAContext()
        
        var isAvailable = false
        
        var authError: LAError?
        
        var error: NSError?
        
        if context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            
            isAvailable = true
            
        } else if let err = error {
            
            authError = LAError(_nsError: err)
            
        }
        
        completion(isAvailable, authError)
        
    }
    
    public class func authenticate(message: String, completion: @escaping TouchIdAttemptCompletion) {
        
        let context = LAContext()
        
        TouchIdUtils.isAvailable { (isAvailable, authError) in
            
            if isAvailable {
                
                context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: message, reply: { isSuccess, error in
                    
                    if isSuccess {
                        
                        completion(isSuccess, nil)
                        
                    } else if let err = error as? NSError,
                        err.code == LAError.userCancel.rawValue {
                        
                        completion(false, nil)
                        
                    } else {
                    
                        completion(false, error)
                    
                    }
                    
                })
                
            } else {
                
                completion(false, authError?._nsError)
                
            }
            
        }
        
    }
    
}
