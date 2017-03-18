
public enum HttpResponseCodes: Int {
    
    case `continue` = 100
    case ok = 200
    case created = 201
    case noContent = 204
    case partialContent = 206
    case movedPermanently = 301
    case found = 302
    case seeOther = 303
    case notModified = 304
    case temporaryRedirect = 307
    case permanentRedirect = 308
    case badRequest = 400
    case notFound = 404
    case gone = 410
    case preconditionFailed = 412
    case preconditionRequired = 428
    case unavailableForLegalReasons = 451
    case internalServerError = 500
    case notImplemented = 501
    case badGateway = 502
    case serviceUnavailable = 503
    case gatewayTimeout = 504
    
}
