
let contentLength = "Content-Length"
let carriageReturn = "\r\n".data(using: String.Encoding.utf8)
let boundaryStart = "--0xKhTmLbOuNdArY\r\n".data(using: String.Encoding.utf8)
let boundaryClose = "--0xKhTmLbOuNdArY--\r\n".data(using: String.Encoding.utf8)
let encoding = "Content-Transfer-Encoding: binary\r\n\r\n".data(using: String.Encoding.utf8)
let contentType = "Content-Type: application/octet-stream\r\n\r\n".data(using: String.Encoding.utf8)
let fileNameField = "Content-Disposition: form-data; name=\"file\"; filename=\"%@\"\r\n"
let defaultFileName = "filename.jpeg"
