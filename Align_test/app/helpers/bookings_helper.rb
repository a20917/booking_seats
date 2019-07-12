module BookingsHelper
  def seat_list
    seats = []
    ['A','B','C'].each do |x|
      [*1..10].each do |y|
        seats.push x + y.to_s
      end
    end
    seats
  end
end
