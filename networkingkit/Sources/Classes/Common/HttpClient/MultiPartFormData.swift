
public protocol MultiPartFormData {
    
    var fileName: String? {get set}
    var fileData: NSMutableData? {get set}
    var queryFields: [String:String]? {get set}
    
}
