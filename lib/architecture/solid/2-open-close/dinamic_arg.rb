# Dynamic Default Values for Method Arguments
# here is the time arg is dinamic

def log_event(message, time: Time.now.strftime("%F %T"))
  puts "[ #{time}]  #{message}"
end

log_event("create user")