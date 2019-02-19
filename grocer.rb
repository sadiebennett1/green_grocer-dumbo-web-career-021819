def consolidate_cart(cart)
  # code here
  final_h = {}
  cart.each do |hash|
    hash.each do |item, info|
      if final_h.keys.include?(item)
        final_h[item][:count] += 1
      else
        arr = info.values
        final_h[item] = {:price => arr[0], :clearance => arr[1], :count => 1}
      end
    end
  end
  return final_h
end

def apply_coupons(cart, coupons)
#   # code here
#   final_h = {}
#   cart.each do |item, descript_hash|
#     descript_hash.each do |title, num|
#       if title == :clearance && num == true
#         coupons.each do |adj, descript|
#           if adj == :item && descript == item
#
#
#       else
#         final_h[item] = descript_hash
#
#
#   coupons.each do |title, descript|
#     if title == :item
#       coup = "#{descript} W/ COUPON"
#       final_h[coup] = {:price => 0 , :clearance => true, :count => 1}
#       coupons.each do |title, descript|
#         if title == :cost
#           final_h[coup][:price] += descript
#         end
#       end
#     end
#   end
#   cart.each do |title, descript_hash|
#     coupons.each do |title2, descript2|
#       if title2 == :item && descript2 == title
#         subtract = 0
#         coupons.each do |title2, descript2|
#           if title == :num
#             subtract += descript2
#           end
#         end
#         cart[title][:count] -= subtract
#         final_h[title] = descript_hash
#       else
#         final_h[title] = descript_hash
#       end
#     end
#   end
#   return final_h
  # coupons.each do |coupon_hash|
  #   fruit_name = coupon_hash[:item]
  #   new_coupon_hash = {
  #     :price => coupon_hash[:cost],
  #     :clearance => "true",
  #     :count => coupon_hash[:num]
  #   }
  #
  #    if cart.key?(fruit_name)
  #     new_coupon_hash[:clearance] = cart[fruit_name][:clearance]
  #     if cart[fruit_name][:count]>= new_coupon_hash[:count]
  #       new_coupon_hash[:count] = (cart[fruit_name][:count]/new_coupon_hash[:count]).floor
  #       cart[fruit_name][:count] = (coupon_hash[:num])%(cart[fruit_name][:count])
  #     end
  #     cart[fruit_name + " W/COUPON"] = new_coupon_hash
  #   end
  #   end
  # return cart
    item = coupon_hash[:item]

    if !hash[item].nil? && hash[item][:count] >= coupon_hash[:num]
      temp = {"#{item} W/COUPON" => {
        :price => coupon_hash[:cost],
        :clearance => hash[item][:clearance],
        :count => 1
        }}

      if hash["#{item} W/COUPON"].nil?
        hash.merge!(temp)
      else
        hash["#{item} W/COUPON"][:count] += 1
        #hash["#{item} W/COUPON"][:price] += coupon_hash[:cost]
      end

      hash[item][:count] -= coupon_hash[:num]
    end
  end
  hash
end

def apply_clearance(cart)
  # code here
  new_hash = {}
  cart.each do |item, descript_hash|
    if descript_hash[:clearance] == true
        description = {}
        descript_hash.each do |title, num|
            if title == :price
                new = num - (num * 0.20)
                description[title] = new
            else
                description[title] = num
            end
            new_hash[item] = description
        end
    else
        new_hash[item] = descript_hash
    end

  end
  return new_hash
end

def checkout(cart, coupons)
  # code here
  cart = consolidate_cart(items)
  cart1 = apply_coupons(cart, coupons)
  cart2 = apply_clearance(cart1)

  total = 0

  cart2.each do |name, price_hash|
    total += price_hash[:price] * price_hash[:count]
  end

  total > 100 ? total * 0.9 : total

end
