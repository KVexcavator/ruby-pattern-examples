def res(opt)
  res = []
  opt.each do |item|
    case
    when item.to_i.to_s == item
      res << item.to_i
    when item == "C"
      res.pop
    when item == "D"
      el = res.pop
      res << (el*2)
    when item == "+"
      el = res.sum
      res << el
    end
  end
  p res
  res.sum
end

opt = ["5","2", "4", "-2", "0","C", "0", "D","+"]
p res(opt)
