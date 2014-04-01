Analytics = AnalyticsRuby # Alias for convenience
Analytics.init({
    secret: ENV["SEGMENTIO_SECRET"],
    on_error: Proc.new { |status, msg| print msg } # Optional error handler
})