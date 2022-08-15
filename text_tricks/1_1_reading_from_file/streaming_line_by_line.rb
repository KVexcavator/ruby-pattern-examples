#
File.open("access_log") do |log_file|
  log_file.each_line do |request|
    if request.start_with?("127.0.0.1 ")
      puts request
    end
  end
end
# тоже но короче
File.foreach("access_log") do |request|
  if request.start_with?("127.0.0.1 ")
    puts request
  end
end
