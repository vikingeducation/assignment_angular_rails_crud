class PinsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update, :destroy]

  def index
    @pins = Pin.all

    respond_to do |format|
      format.json { render json: @pins.to_json(include: :user) }
    end
  end

  def show
    @pin = Pin.find_by_id(params[:id])

    respond_to do |format|
      format.json { render json: @pin.to_json(include: :user) }
    end
  end

  def create
    @pin = Pin.new(pin_params)
    @pin.user = User.first

    respond_to do |format|
      if @pin.save
        format.json { render json: @pin.to_json(include: :user) }
      else
        format.json { render nothing: true, status: :unprocessable_entity }
      end
    end
  end

  def update
    @pin = Pin.find_by_id(params[:id])

    respond_to do |format|
      if @pin.update(pin_params)
        format.json { render json: @pin.to_json(include: :user) }
      else 
        format.json { render nothing: true, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @pin = Pin.find_by_id(params[:id])

    respond_to do |format|
      if @pin.destroy
        format.json { render json: @pin.to_json(include: :user) }
      end
    end
  end

  private

  def pin_params
    params.require(:pin).permit(:item_name, :buy_sell, :description, :user_id)
  end
end
