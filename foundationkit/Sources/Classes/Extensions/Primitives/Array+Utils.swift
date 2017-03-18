
public extension Array {
    
    public func indexForElement(_ element:String) -> Int {
        
        var itemIndex = 0
        
        for (index, item) in enumerated() {
            
            if String(describing: item) == element {
                
                itemIndex = index
                
                break
                
            }
            
        }
        
        return itemIndex
        
    }
    
}
