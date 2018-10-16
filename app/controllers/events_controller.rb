class EventsController < ApplicationController
  rescue_from Exceptions::InvalidZip, with: :invalid_zip
  rescue_from Exceptions::InvalidDate, with: :invalid_date

  def index
    ensure_datetime_present
    persist_session
    @events = EventGetter.new(user_params).get_events
  end

  private

  def user_params
    params.slice('zipcode', 'datetime').symbolize_keys
  end

  def persist_session
    user_params.each do |key, value|
      session[key] = value
    end
  end

  def ensure_datetime_present
    if params['datetime'] == ""
      session[:datetime] = today
      params[:datetime] = today
    end
  end

  def today
      today = DateTime.now.strftime("%-m/%d")  
  end

  def invalid_zip
    invalid_redirect('zipcode')
  end

  def invalid_date
    invalid_redirect('datetime')
  end

  def invalid_redirect(bad_param)
    session[bad_param] = nil
    flash[:error] = "Sorry, '#{params[bad_param]}' won't work as a #{bad_param}."
    redirect_to(:root)
  end
end
