class Movie < ActiveRecord::Base
    def self.returnRatings
    arr=Array.new
    self.select("rating").uniq.each{ |item| arr.push(item.rating)}
    return arr.sort.uniq
    end
end
