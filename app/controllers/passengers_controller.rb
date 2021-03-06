class PassengersController < ApplicationController
  def index
    @passengers = Passenger.all
  end

  def show
    @result_passenger = Passenger.find(params[:id])
  end

  def edit
    @passenger = Passenger.find(params[:id])
  end

  def update
    @passenger = Passenger.find(params[:id])

    if @passenger.update(passenger_params)
      redirect_to passenger_path
    else
      render "edit"
    end
  end

  def new
    @passenger = Passenger.new
  end

  def create
    @passenger = Passenger.create passenger_params
    if @passenger.id != nil
      redirect_to passengers_path
    else
      render "new"
    end
  end

  def destroy
    passenger = Passenger.find(params[:id])
    passenger.trips.each do |trip|
      Trip.destroy(trip.id)
    end
    Passenger.destroy(params[:id])
    redirect_to passengers_path
  end

  private

  def passenger_params
    params.require(:passenger).permit(:name, :phone_num)
  end
end
