
extension Dictionary {
    
    mutating func append(dictionary: Dictionary) {
        
        for (key,value) in dictionary {
            
            self.updateValue(value, forKey:key)
            
        }
        
    }
    
}
