class EventsController < ApplicationController
  rescue_from Exceptions::InvalidZip, with: :invalid_zip
  rescue_from Exceptions::InvalidDate, with: :invalid_date

  def index
    @events = WhatToDo.new(params["params"]).get_events
  end

  private

  def invalid_zip
    flash[:error] = "Sorry, you'll need to input a 5 digit zip code."
    redirect_to(:back)
  end

  def invalid_date
    flash[:error] = "Sorry, we can't understand that date format."
    redirect_to(:back)
  end
end
