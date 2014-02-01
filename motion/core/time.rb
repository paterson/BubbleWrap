class Time
  
  def self.iso8601(time)
    cached_date_formatter("yyyy-MM-dd'T'HH:mm:ss'Z'").
      dateFromString(time)
  end
  
  def self.iso8601_with_timezone(time)
    cached_date_formatter("yyyy-MM-dd'T'HH:mm:ssZZZZZ").
      dateFromString(time)
  end
  
  def self.iso8601_without_time(time) #should this really be in Time?
    cached_date_formatter("yyyy-MM-dd").
      dateFromString(time)
  end
  
  def self.strptime(time)
    iso8601(time) || iso8601_with_timezone(time) || iso8601_without_time(time)
  end

  private

  def self.cached_date_formatter(dateFormat)
    Thread.current[:date_formatters] ||= {}
    Thread.current[:date_formatters][dateFormat] ||= 
      NSDateFormatter.alloc.init.tap do |formatter|
        formatter.dateFormat = dateFormat
        formatter.timeZone   = NSTimeZone.timeZoneWithAbbreviation "UTC"
      end
  end

end
