
import Foundation

public extension Date {
    
    public func numberOfDaysSinceNow() -> TimeInterval {
        
        let now = Date()
        
        let numberOfSeconds = now.timeIntervalSince(self)
        
        let numberOfDays = numberOfSeconds / kTimeIntervalOfOneDay
        
        return numberOfDays
        
    }
    
    public func numberOfDaysFromNow() -> TimeInterval {
        
        let now = Date()
        
        let numberOfSeconds = timeIntervalSince(now)
        
        let numberOfDays = numberOfSeconds / kTimeIntervalOfOneDay
        
        return numberOfDays
        
    }
    
    public func numberOfDaysSinceDate(_ date:Date) -> TimeInterval {
        
        let numberOfSeconds = date.timeIntervalSince(self)
        
        let numberOfDays = numberOfSeconds / kTimeIntervalOfOneDay
        
        return numberOfDays
        
    }
    
    public func numberOfDaysFromDate(_ date:Date) -> TimeInterval {
        
        let numberOfSeconds = timeIntervalSince(date)
        
        let numberOfDays = numberOfSeconds / kTimeIntervalOfOneDay
        
        return numberOfDays
        
    }
    
    public func numberOfWeeksToDate(_ date: Date) -> Int {
        
        let dateComponents: Set<Calendar.Component> = [Calendar.Component.weekOfYear]
        
        let calendar = Calendar.current
        
        let components = calendar.dateComponents(dateComponents, from: self, to: date)
        
        return (components.weekOfYear ?? 0) + 1
        
    }
    
    public static func dateStringFromComponents(_ components:DateComponents) -> String {
        
        var day = ""
        
        let cDay = components.day ?? 0
        
        if cDay  > 0 {
            
            let text = components.day == 1 ? NSLocalizedString("day", comment:"") : NSLocalizedString("days", comment:"")
            
            day = " \(components.day) " + text
            
        }
        
        var hours = ""
        
        let cHour = components.hour ?? 0
        
        if cHour > 0 {
            
            let text = components.hour == 1 ? NSLocalizedString("hour", comment:"") : NSLocalizedString("hours", comment:"")
            
            hours = " \(components.hour) " + text
            
        }
        
        var minutes = ""
        var seconds = ""
        
        if let minute = components.minute, minute > 0 {
            
            minutes = " \(components.minute) " + (components.minute == 1 ? NSLocalizedString("minute", comment:"") : NSLocalizedString("minutes", comment:""))
            
        }else {
            
            seconds = " \(components.second) " + (components.minute == 1 ? NSLocalizedString("second", comment:"") : NSLocalizedString("seconds", comment:""))
            
        }
        
        return day + hours + minutes + seconds
        
    }
    
    public func timeLeftComponentsToNow() -> DateComponents {
        
        let calendar = Calendar.current
        
        let dateComponents: Set<Calendar.Component> = [Calendar.Component.day, Calendar.Component.hour, Calendar.Component.minute, Calendar.Component.second]
        
        let now = Date()
        
        let components = calendar.dateComponents(dateComponents, from:now, to:self)
        
        return components
        
    }
    
    public func numberOfDaysToNow() -> TimeInterval {
        
        let now = Date()
        
        let numberOfSeconds = timeIntervalSince(now)
        
        let numberOfDays = numberOfSeconds / kTimeIntervalOfOneDay
        
        return numberOfDays
        
    }
    
    public func yesterdayOrDdmmyyString() -> String? {
        
        var string: String?
        
        let yesterday = Date().addingTimeInterval(-kTimeIntervalOfOneDay)
        
        if isEqualToDateIgnoringTime(yesterday) {
            
            string = NSLocalizedString("Yesterday", comment:"")
            
        } else {
            
            string = ddmmyyString()
            
        }
        
        return string
        
    }
    
    public func year() -> Int {
        
        let calendar = Calendar.current
        
        let components = calendar.dateComponents([Calendar.Component.year], from:self)
        
        return components.year ?? 0
        
    }
    
    public func month() -> Int {
        
        let calendar = Calendar.current
        
        let components = calendar.dateComponents([Calendar.Component.month], from:self)
        
        return (components.month ?? 0) + 1
        
    }
    
    public func day() -> Int {
        
        let calendar = Calendar.current
        
        let components = calendar.dateComponents([Calendar.Component.day], from:self)
        
        return (components.day ?? 0)
        
    }
    
    public func isEqualToDateIgnoringTime(_ date:Date) -> Bool {
        
        let calendar = Calendar.current
        
        let components1 = calendar.dateComponents(kYearMonthDayUnitFlags, from:self)
        
        let components2 = calendar.dateComponents(kYearMonthDayUnitFlags, from:date)
        
        return (components1.year == components2.year) && (components1.month == components2.month) && (components1.day == components2.day)
        
    }
    
    public func addHours(_ hours:Int) -> Date {
        
        let calendar = Calendar.current
        
        var components = calendar.dateComponents(kYearMonthDayHourMinuteUnitFlags, from:self)
        
        if let hour = components.hour {
            
            components.hour = hour + hours
            
        }
        
        let date = calendar.date(from: components) ?? self
        
        return date
        
    }
    
    public func addMinutes(_ minutes:Int) -> Date {
        
        let calendar = Calendar.current
        
        var components = calendar.dateComponents(kYearMonthDayHourMinuteUnitFlags, from:self)
        
        if let minute = components.minute {
            
            components.minute = minute + minutes
            
        }
        
        let date = calendar.date(from: components) ?? self
        
        return date
        
    }
    
    public func addDays(_ days:Int) -> Date {
        
        let calendar = Calendar.current
        
        var components = calendar.dateComponents(kYearMonthDayUnitFlags, from:self)
        
        if let day = components.day {
            
            components.day = day + days
            
        }
        
        let date = calendar.date(from: components) ?? self
        
        return date
        
    }
    
    public func addYears(_ years:Int) -> Date {
        
        let calendar = Calendar.current
        
        var components = calendar.dateComponents(kYearMonthDayUnitFlags, from:self)
        
        if let year = components.year {
            
            components.year = year + Int(years)
            
        }
        
        let date = calendar.date(from: components) ?? self
        
        return date
        
    }
    
    public func dateWithoutTime() -> Date {
        
        let calendar = Calendar.current
        
        let components = calendar.dateComponents(kYearMonthDayUnitFlags, from:self)
        
        var dateOnly = calendar.date(from: components) ?? self
        
        let secondsToAdd = Double(TimeZone.current.secondsFromGMT(for:self))
        
        dateOnly = dateOnly.addingTimeInterval(secondsToAdd)
        
        return dateOnly
        
    }
    
    public func isToday() -> Bool {
        
        var isToday = false
        
        let calendar = Calendar.current
        
        var components = calendar.dateComponents([Calendar.Component.day], from:Date())
        
        let today = calendar.date(from: components)
        
        components = calendar.dateComponents([Calendar.Component.day], from:self)
        
        let otherDate = calendar.date(from: components)
        
        if let date1 = today, let date2 = otherDate , (date1 == date2) {
            
            isToday = true
            
        }
        
        return isToday
        
    }
    
    public func isYesterday() -> Bool {
        
        var isYesterday = false
        
        let calendar = Calendar.current
        
        var components = calendar.dateComponents([Calendar.Component.day], from:Date().addingTimeInterval(-kTimeIntervalOfOneDay))
        
        let today = calendar.date(from: components)
        
        components = calendar.dateComponents([Calendar.Component.day], from:self)
        
        let otherDate = calendar.date(from: components)
        
        if let date1 = today, let date2 = otherDate , date1 == date2 {
            
            isYesterday = true
            
        }
        
        return isYesterday
        
    }
    
    public func isCurrentYear() -> Bool {
        
        let calendar = Calendar.current
        
        let components = calendar.dateComponents([Calendar.Component.year], from:Date())
        
        let nowYear = components.year
        
        return nowYear == year()
        
    }
    
    public static func monthStrings() -> [String] {
        
        return monthNumbers
        
    }
    
    public static func yearStringsForYearRange(_ range:Int) -> [String] {
        
        let date = Date()
        
        var years = [String]()
        
        for i in 0...range {
            
            let components: DateComponents = DateComponents()
            
            (components as NSDateComponents).setValue(i, forComponent:.year)
            
            if let futureDate = Calendar.current.date(byAdding: components, to:date), let dateString = futureDate.yyyyString() {
                
                years.append(dateString)
                
            }
            
        }
        
        return years
        
    }
    
    public static func isValidDayNumber(_ text:String) -> Bool {
        
        var valid = false
        
        if dayNumbers.contains(text) {
            
            valid = true
            
        }
        
        if altDayNumbers.contains(text) {
            
            valid = true
            
        }
        
        return valid
        
    }
    
    public static func isValidMonthNumber(_ text:String) -> Bool {
        
        var valid = false
        
        if monthNumbers.contains(text) {
            
            valid = true
            
        }
        
        if altMonthNumbers.contains(text) {
            
            valid = true
            
        }
        
        return valid
        
    }
    
    public static func dateByAddingDays(_ date:Date, numberOfDays:Int) -> Date? {
        
        var returnDate: Date?
        
        var dayComponent = DateComponents()
        
        dayComponent.day = numberOfDays
        
        let calendar = Calendar.current
        
        if let newDate = calendar.date(byAdding: dayComponent, to:date) {
            
            returnDate = newDate
            
        }
        
        return returnDate
        
    }
    
    public func startOfWeekDate(_ locale:Locale) -> Date? {
        
        let calendar = Calendar.current
        
        let currentDateComponents = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)
        
        var startOfWeek = calendar.date(from: currentDateComponents)
        
        let secondsToAdd = Double(TimeZone.current.secondsFromGMT(for: self))
        
        startOfWeek = startOfWeek?.addingTimeInterval(secondsToAdd)
        
        return startOfWeek
        
    }
    
    //MARK: - Formatters
    
    public func ddsfMMMMString() -> String? {
        
        let df = Date.ddFormatter
        
        var dateString = df.string(from: self)
        
        let dfDay = Date.dFormatter
        
        let day = Int(dfDay.string(from: self)) ?? 0
        
        let suffixes = suffix_string.components(separatedBy: "|")
        
        let suffix = suffixes[day]
        
        dateString += suffix
        
        let mfDay = Date.MMMMFormatter
        
        let month = mfDay.string(from: self)
        
        dateString += " \(month)"
        
        return dateString
        
    }
    
    public func EEEEddsfMMMMString() -> String? {
        
        let df = Date.EEEEddFormatter
        
        var dateString = df.string(from: self)
        
        let dfDay = Date.dFormatter
        
        let day = Int(dfDay.string(from: self)) ?? 0
        
        let suffixes = suffix_string.components(separatedBy: "|")
        
        let suffix = suffixes[day]
        
        dateString += suffix
        
        let mfDay = Date.MMMMFormatter
        
        let month = mfDay.string(from: self)
        
        dateString += " \(month)"
        
        return dateString
        
    }
    
    public func EEEEdsfMMMMString() -> String? {
        
        let df = Date.EEEEdFormatter
        
        var dateString = df.string(from: self)
        
        let dfDay = Date.dFormatter
        
        let day = Int(dfDay.string(from: self)) ?? 0
        
        let suffixes = suffix_string.components(separatedBy: "|")
        
        let suffix = suffixes[day]
        
        dateString += suffix
        
        let mfDay = Date.MMMMFormatter
        
        let month = mfDay.string(from: self)
        
        dateString += " \(month)"
        
        return dateString
        
    }
    
    
    public func EEEEOrTodayString() -> String? {
        
        var dateString = NSLocalizedString("Today", comment:"")
        
        let df = Date.EEEEFormatter
        
        if isToday() == false {
            
            dateString = df.string(from: self)
            
        }
        
        return dateString
        
    }
    
    public func TodayOrYesterdayOrNumberOfDaysString() -> String? {
        
        var dateString = ""
        
        if isToday() == true {
            
            dateString = NSLocalizedString("Today", comment: "")
            
        }else if isYesterday() == true {
            
            dateString = NSLocalizedString("Yesterday", comment: "")
            
        }else {
            
            let numdays = numberOfDaysSinceNow()
            
            let intValue = Int(numdays)
            
            var days = NSLocalizedString("days", comment:"")
            
            if intValue == 1 {
                
                days = NSLocalizedString("day", comment:"")
                
            }
            
            dateString = "\(intValue) \(days) " + NSLocalizedString("ago", comment:"")
            
        }
        
        return dateString
        
    }
    
    public func TodayOrYesterdayOrHumanDate() -> String? {
        
        var dateString = ""
        
        if isToday() == true {
            
            dateString = NSLocalizedString("Today", comment: "")
            
        }else if isYesterday() == true {
            
            dateString = NSLocalizedString("Yesterday", comment: "")
            
        } else {
            
            if let formatted = EEEEddsfMMMMString() {
                
                dateString = formatted
                
            }
            
        }
        
        return dateString
        
    }
    
    public func EEEEEString() -> String? {
        
        let df = Date.EEEEEFormatter
        
        let dateString = df.string(from: self)
        
        return dateString
        
    }
    
    public func yyyyMMss() -> String? {
        
        let df = Date.yyyyMMddFormatter
        
        let dateString = df.string(from: self)
        
        return dateString
        
    }
    
    public func ddMMMM() -> String? {
        
        let df = Date.ddMMMMFormatter
        
        let dateString = df.string(from: self)
        
        return dateString
        
    }
    
    public func ddMMMMmedium() -> String? {
        
        let df = Date.ddMMMMMediumFormatter
        
        let dateString = df.string(from: self)
        
        return dateString
        
    }
    
    public func ddMMMMyyyy() -> String? {
        
        let df = Date.ddMMMMyyyyFormatter
        
        let dateString = df.string(from: self)
        
        return dateString
        
    }
   
    public func ddMMMMyyyymedium() -> String? {
        
        let df = Date.ddMMMMyyyyMediumFormatter
        
        let dateString = df.string(from: self)
        
        return dateString
        
    }
    
    public func HHmm() -> String? {
        
        let df = Date.HHmmFormatter
        
        let dateString = df.string(from: self)
        
        return dateString
        
    }
    
    public func hmma() -> String? {
        
        let df = Date.hmmaFormatter
        
        let dateString = df.string(from: self)
        
        return dateString
        
    }
    
    public func HHmmddMMM() -> String? {
        
        let df = Date.HHmmddMMMFormatter
        
        let dateString = df.string(from: self)
        
        return dateString
        
    }
    
    public func ddmmyyString() -> String? {
        
        let df = Date.ddMMyyFormatter
        
        let dateString = df.string(from: self)
        
        return dateString
        
    }
    
    public func ddmmyyyyString() -> String? {
        
        let df = Date.ddMMyyyyFormatter
        
        let dateString = df.string(from: self)
        
        return dateString
        
    }
    
    public func yyyMMdd() -> String? {
        
        let df = Date.yyyyMMddFormatter
        
        let dateString = df.string(from: self)
        
        return dateString
        
    }
    
    public func yyyy() -> String? {
        
        let df = Date.yyyyFormatter
        
        let dateString = df.string(from: self)
        
        return dateString
        
    }
    
    public func yyyyString() -> String? {
        
        let df = Date.yyyyFormatter
        
        let dateString = df.string(from: self)
        
        return dateString
        
    }
    
    public func yyyMMddTHHmmss() -> String? {
        
        let df = Date.yyyyMMddTHHmmssFormatter
        
        let dateString = df.string(from: self)
        
        return dateString
        
    }
    
    public func yyyMMddHHmmss() -> String? {
        
        let df = Date.yyyyMMddHHmmssFormatter
        
        let dateString = df.string(from: self)
        
        return dateString
        
    }
    
    public func MMMddHHmmss() -> String? {
        
        let df = Date.MMMddHHmmssaFormatter
        
        let dateString = df.string(from: self)
        
        return dateString
        
    }
    
    public func MMyy() -> String? {
        
        let df = Date.MMyyFormatter
        
        let dateString = df.string(from: self)
        
        return dateString
        
    }
    
    public func MM() -> String? {
        
        let df = Date.MMFormatter
        
        let dateString = df.string(from: self)
        
        return dateString
        
    }
    
    public func EEEEhha() -> String? {
        
        let formatter = Date.EEEEhhaFormatter
        
        let dateString = formatter.string(from: self)
        
        return dateString
        
    }

    public func ddString() -> String? {
        
        let df = Date.ddFormatter
        
        let dateString = df.string(from: self)
        
        return dateString
        
    }
    
    public func MMMdString() -> String? {
        
        let df = Date.MMMdFormatter
        
        let dateString = df.string(from: self)
        
        return dateString
        
    }
    
    public func MMMddString() -> String? {
        
        let df = Date.MMMddFormatter
        
        let dateString = df.string(from: self)
        
        return dateString
        
    }
    
    public func MMMyyString() -> String? {
        
        let df = Date.MMMyyFormatter
        
        let dateString = df.string(from: self)
        
        return dateString
        
    }
    
    public func ccccString() -> String? {
        
        let df = Date.ccccFormatter
        
        let dateString = df.string(from: self)
        
        return dateString
        
    }
    
    public func cccString() -> String? {
        
        let df = Date.cccFormatter
        
        let dateString = df.string(from: self)
        
        return dateString
        
    }
    
    public func cccdsfString() -> String? {
        
        let df = Date.cccdFormatter
        
        var dateString = df.string(from: self)
        
        let dfDay = Date.dFormatter
        
        let day = Int(dfDay.string(from: self)) ?? 0
        
        let suffixes = suffix_string.components(separatedBy: "|")
        
        let suffix = suffixes[day]
        
        dateString += suffix
        
        return dateString
        
    }
    
    public func MMMMdsfString() -> String? {
        
        let df = Date.MMMMdFormatter
        
        var dateString = df.string(from: self)
        
        let dfDay = Date.dFormatter
        
        let day = Int(dfDay.string(from: self)) ?? 0
        
        let suffixes = suffix_string.components(separatedBy: "|")
        
        let suffix = suffixes[day]
        
        dateString += suffix
        
        return dateString
        
    }
    
    public func ccccdsfMMMMString() -> String? {
        
        let df = Date.ccccdFormatter
        
        var dateString = df.string(from: self)
        
        let dfDay = Date.dFormatter
        
        let day = Int(dfDay.string(from: self)) ?? 0
        
        let suffixes = suffix_string.components(separatedBy: "|")
        
        let suffix = suffixes[day]
        
        dateString += suffix
        
        let mfDay = Date.MMMMFormatter
        
        let month = mfDay.string(from: self)
        
        dateString += " \(month)"
        
        return dateString
        
    }

    
}
