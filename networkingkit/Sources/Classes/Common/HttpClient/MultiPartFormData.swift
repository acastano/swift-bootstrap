
public protocol MultiPartFormData {
    
    var fileData: Data? {get set}
    var fileName: String? {get set}
    var queryFields: [String:String]? {get set}
    
}
