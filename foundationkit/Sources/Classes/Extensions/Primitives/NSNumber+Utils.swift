
public extension NSNumber {

    public func formattedCurrencyForCurrentLocale() -> String? {
        
        return formattedCurrency(Locale.current)
        
    }
    
    public func formattedCurrency(_ locale:Locale) -> String? {
        
        var formattedString: String?
        
        let formatter = NumberFormatter()
        
        formatter.numberStyle = .currency
        
        formatter.locale = locale
        
        if let string = formatter.string(from: self) {
            
            formattedString = string
            
        }

        return formattedString
        
    }
    
    public func formattedDecimal(_ places: Int) -> String? {
        
        var formattedString: String?
        
        let formatter = NumberFormatter()
        
        formatter.minimumIntegerDigits = 1
        
        formatter.minimumFractionDigits = places
        
        formatter.maximumFractionDigits = places
        
        if let string = formatter.string(from: self) {
            
            formattedString = string
            
        }
        
        return formattedString
        
    }
    
}
