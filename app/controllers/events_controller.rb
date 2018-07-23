class EventsController < ApplicationController
  rescue_from Exceptions::InvalidZip, with: :invalid_zip
  rescue_from Exceptions::InvalidDate, with: :invalid_date

  def index
    persist_session
    if @events = WhatToDo.new(user_params).get_events
      @events_count = @events.count
    end
  end

  private

  def user_params
    params.slice("zipcode","datetime")
  end

  def persist_session
    user_params.each do |key, value|
      session[key] = value
    end
  end

  def invalid_zip
    session["zipcode"] = nil
    flash[:error] = "Sorry, '#{params["zipcode"]}' won't work as a zipcode."
    redirect_to(:root)
  end

  def invalid_date
    session["datetime"] = nil
    flash[:error] = "Sorry, '#{params["datetime"]}' won't work as a date."
    redirect_to(:root)
  end
end
