
import UIKit
import Foundation

public protocol ErrorTranslator: class {
    
    func imageForError(_ error:NSError?) -> UIImage?
    
    func localizedTitleForError(_ error:NSError?) -> String?
    
    func localizedMessageForError(_ error:NSError?) -> String?
    
}
