class BookingsController < ApplicationController
  before_action :authenticate_user! , only: [:new, :update]
  before_action :find_booking_and_check_permission, only: [:edit, :destroy, :update]
  include BookingsHelper

  def index
    @bookings = Booking.all
  end

  def show
    @booking = Booking.find(params[:id])
  end

  def edit
    @booking = Booking.find(params[:id])
    @seats = seat_list
  end

  def new
    @booking = Booking.new
    @seats = seat_list
  end

  def create
    @booking = Booking.new(booking_params)
    unless avalible_check?(booking_params)
      flash[:alert] = invalid_msg(booking_params)
      redirect_to new_booking_path
      return
    end

    @booking.user_id = current_user[:id]
    if @booking.save
      redirect_to bookings_path
    else
      redirect_to new_booking_path
    end
  end

  def update
    unless avalible_check?(booking_params, true)
      flash[:alert] = invalid_msg(booking_params)
      redirect_to edit_booking_path(@booking)
      return
    end

    if @booking.update(booking_params)
      redirect_to bookings_path, notice: "Update Success"
    else
      render :edit
    end
  end

  def destroy
    @booking.destroy
    flash[:alert] = "Booking deleted"
    redirect_to bookings_path
  end

  private

  def find_booking_and_check_permission
    @booking = Booking.find(params[:id])
    if current_user != @booking.user
      redirect_to root_path, alert: "You have no permission."
    end
  end

  def booking_params
    params.require(:booking).permit(:desk, :date_from, :date_to)
  end

  def avalible_check?(booking_params, self_check = false)
    bookings = Booking.where("desk = ? AND ((? BETWEEN date_from AND date_to) OR (? BETWEEN date_from AND date_to))",
                             booking_params[:desk], booking_params[:date_from],
                             booking_params[:date_to])
    bookings = bookings.where("id <> ?", params.require(:id)) if self_check
    return false if bookings.count > 0
    true
  end

  def invalid_msg(paras)
    "The desk [#{paras[:desk]}] is conflicted with other booking " +
    "during [#{paras[:date_from]} - #{paras[:date_to]}]"
  end
end
