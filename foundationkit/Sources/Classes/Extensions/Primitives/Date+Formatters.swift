
extension Date {
    
    static let ddFormatter: DateFormatter = {
        
        let formatter = dateFormatter("dd")
        
        return formatter
        
    }()
    
    static let dFormatter: DateFormatter = {
        
        let formatter = dateFormatter("d")
        
        return formatter
        
    }()
    
    static let MMMMFormatter: DateFormatter = {
        
        let formatter = dateFormatter("MMMM")
        
        return formatter
        
    }()
    
    static let EEEEddFormatter: DateFormatter = {
        
        let formatter = dateFormatter("EEEE dd")
        
        return formatter
        
    }()
    
    static let EEEEdFormatter: DateFormatter = {
        
        let formatter = dateFormatter("EEEE d")
        
        return formatter
        
    }()
    
    static let EEEEFormatter: DateFormatter = {
        
        let formatter = dateFormatter("EEEE")
        
        return formatter
        
    }()
    
    
    static let EEEEEFormatter: DateFormatter = {
        
        let formatter = dateFormatter("EEEEE")
        
        return formatter
        
    }()
    
    static let yyyyMMddFormatter: DateFormatter = {
        
        let formatter = dateFormatter("yyyy-MM-dd")
        
        return formatter
        
    }()
    
    static let ddMMMMFormatter: DateFormatter = {
        
        let formatter = dateFormatter("dd MMMM")
        
        return formatter
        
    }()
    
    static let ddMMMMMediumFormatter: DateFormatter = {
        
        let formatter = dateFormatter("dd MMMM")
        
        formatter.dateStyle = .medium
        
        return formatter
        
    }()
    
    static let ddMMMMyyyyFormatter: DateFormatter = {
        
        let formatter = dateFormatter("dd MMMM yyyy")
        
        return formatter
        
    }()
    
    static let ddMMMMyyyyMediumFormatter: DateFormatter = {
        
        let formatter = dateFormatter("dd MMMM yyyy")
        
        formatter.dateStyle = .medium
        
        return formatter
        
    }()
    
    static let yyyyFormatter: DateFormatter = {
        
        let formatter = dateFormatter("yyyy")
        
        return formatter
        
    }()
    
    static let HHmmFormatter: DateFormatter = {
        
        let formatter = dateFormatter("HH:mm")
        
        return formatter
        
    }()
    
    static let hmmaFormatter: DateFormatter = {
        
        let formatter = dateFormatter("h:mma")
        
        formatter.amSymbol = "am"
        
        formatter.pmSymbol = "pm"
        
        return formatter
        
    }()
    
    static let HHmmddMMMFormatter: DateFormatter = {
        
        let formatter = dateFormatter("HH:mm dd-MMM")
        
        return formatter
        
    }()
    
    static let ddMMyyyyFormatter: DateFormatter = {
        
        let formatter = dateFormatter("dd/MM/yyyy")
        
        return formatter
        
    }()
    
    static let ddMMyyFormatter: DateFormatter = {
        
        let formatter = dateFormatter("dd/MM/yy")
        
        return formatter
        
    }()
    
    static let MMMddHHmmssaFormatter: DateFormatter = {
        
        let formatter = dateFormatter("MMM dd HH:mm:ss a")
        
        return formatter
        
    }()
    
    static let MMyyFormatter: DateFormatter = {
        
        let formatter = dateFormatter("MM/yy")
        
        return formatter
        
    }()
    
    static let MMFormatter: DateFormatter = {
        
        let formatter = dateFormatter("MM")
        
        return formatter
        
    }()
    
    static let EEEEhhaFormatter: DateFormatter = {
        
        let formatter = dateFormatter("EEEE, hha")
        
        return formatter
        
    }()
    
    static let MMMdFormatter: DateFormatter = {
        
        let formatter = dateFormatter("MMM d")
        
        return formatter
        
    }()
    
    static let MMMddFormatter: DateFormatter = {
        
        let formatter = dateFormatter("MMM dd")
        
        return formatter
        
    }()
    
    static let MMMyyFormatter: DateFormatter = {
        
        let formatter = dateFormatter("MMM dd")
        
        return formatter
        
    }()
    
    static let ccccFormatter: DateFormatter = {
        
        let formatter = dateFormatter("cccc")
        
        return formatter
        
    }()
    
    static let cccFormatter: DateFormatter = {
        
        let formatter = dateFormatter("ccc")
        
        return formatter
        
    }()
    
    static let cccdFormatter: DateFormatter = {
        
        let formatter = dateFormatter("ccc d")
        
        return formatter
        
    }()
    
    static let MMMMdFormatter: DateFormatter = {
        
        let formatter = dateFormatter("MMMM d")
        
        return formatter
        
    }()
    
    static let ccccdFormatter: DateFormatter = {
        
        let formatter = dateFormatter("cccc d")
        
        return formatter
        
    }()
    
    static let yyyyMMddHHmmssFormatter: DateFormatter = {
        
        let formatter = dateFormatter("yyyy-MM-dd HH:mm:ss")
        
        return formatter
        
    }()
    
    static let yyyyMMddTHHmmssFormatter: DateFormatter = {
        
        let formatter = dateFormatter("yyyy-MM-ddTHH:mm:ss")
        
        return formatter
        
    }()
    
    
    private static func dateFormatter(_ format:String) -> DateFormatter {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = format
        
        dateFormatter.locale = Locale(identifier:"en")
        
        return dateFormatter
        
    }
    
}
