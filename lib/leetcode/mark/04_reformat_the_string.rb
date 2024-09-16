# @param {String} s
# @return {String}
def reformat(s)
  return s if s.length < 2
  nums = s.delete('^0-9').split('').each{|v| v.to_i}
  chars = s.delete('^a-z').split('')
  return "" if nums.empty? or chars.empty?
  output = ""
  output << chars.shift if chars.length > nums.length
  nums.each do |num|
    output << num.to_s
    output << chars.shift if not chars.empty?
  end
  output
end
