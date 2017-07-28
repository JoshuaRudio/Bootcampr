class EventsController < ApplicationController

  def index
    @events = Event.all.order(:date, :time)
    @january = []
    @february = []
    @march = []
    @april = []
    @may = []
    @june = []
    @july = []
    @august = []
    @september = []
    @october = []
    @november = []
    @december = []

    @events.each do |e|
      case e.month
      when '01'
        @january << e
      when '02'
        @february << e
      when '03'
        @march << e
      when '04'
        @april << e
      when '05'
        @may << e
      when '06'
        @june << e
      when '07'
        @july << e
      when '08'
        @august << e
      when '09'
        @september << e
      when '10'
        @october << e
      when '11'
        @november << e
      when '12'
        @december << e
      end
    end
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to @event
    else
      render :new, status: 422
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  private

  def event_params
    params.require(:event).permit(:title, :date, :time, :location, :summary)
  end

end
