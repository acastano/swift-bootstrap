
import UIKit

public typealias VoidCompletion = () -> ()
public typealias IntCompletion = (Int) -> ()
public typealias BoolCompletion = (Bool) -> ()
public typealias ErrorCompletion = (NSError?) -> ()
public typealias ImageCompletion = ((UIImage) -> Void)?
public typealias BoolBoolCompletion = (Bool, Bool) -> ()
public typealias IntErrorCompletion = (Int?, NSError?) -> ()
public typealias BoolErrorCompletion = (Bool, NSError?) -> ()
public typealias URLErrorCompletion = (URL?, NSError?) -> ()
public typealias StringErrorCompletion = (String?, NSError?) -> ()
public typealias AnyErrorCompletion = (AnyObject?, NSError?) -> ()
public typealias StringsErrorCompletion = ([String], NSError?) -> ()
public typealias ArrayErrorCompletion = ([AnyObject]?, NSError?) -> ()
public typealias IntArrayErrorCompletion = (Int, [AnyObject]?, NSError?) -> ()
public typealias StringStringErrorCompletion = (String?, String?, NSError?) -> ()
public typealias StringAnyObjectErrorCompletion = ([String:AnyObject]?, NSError?) -> ()
public typealias ArrayDictionaryErrorCompletion = ([[String:AnyObject]]?, NSError?) -> ()
