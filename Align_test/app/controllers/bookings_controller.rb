class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
  end

  def show
    @booking = Booking.find(params[:id])
  end

  def new
    @booking = Booking.new
    @seats = []
    ['A','B','C'].each do |x|
      [*1..10].each do |y|
        @seats.push x + y.to_s
      end
    end
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.name = "Nick"
    if @booking.save
      redirect_to bookings_path
    else
      render :new
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:name, :desk, :date_from, :date_to)
  end
end
