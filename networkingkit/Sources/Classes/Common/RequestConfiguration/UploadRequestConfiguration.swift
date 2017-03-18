
public protocol UploadRequestConfiguration: RequestConfiguration {
    
    func formData() -> MultiPartFormData?
    
}