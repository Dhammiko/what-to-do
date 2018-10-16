require 'rails_helper'

describe EventsController do
  describe 'GET index' do
    let(:zip) { '90210' }
    let(:date) { '10/10' } 
    let(:params) { { 'zipcode' => '90210', 'datetime' => '10/10' } }
    let(:event) { double('event') }
    let(:whattodo) { double('WhatToDo', get_events: [event])}

    it 'symbolizes the user params' do
      expect(EventGetter).to receive(:new).with(zipcode: zip, datetime: date).and_return(whattodo)

      get :index, params
    end

    context 'events are found' do
      before do
        allow(EventGetter).to receive(:new).with(anything).and_return(whattodo)
      end

      it 'assigns @events' do
        get :index, params

        expect(assigns(:events)).to eq([event])
      end
    end

    let(:referer) { '/' }
    context 'invalid zipcodes' do
      let(:params) { { 'zipcode' => '1234', 'datetime' => '10/10' } }

      before { request.env['HTTP_REFERER'] = referer }

      it 'sets an error message if InvalidZip is raised' do
        get :index, params

        expect(flash[:error]).to be_present
      end

      it 'redirects us back if InvalidZip is raised' do
        get :index, params

        expect(response).to redirect_to(referer)
      end
    end

    context 'invalid dates' do
      let(:params) { { 'zipcode' => '12345', 'datetime' => 'pizza' } }
      before { request.env['HTTP_REFERER'] = referer }

      it 'replaces the datetime with the string "today" if the user left it blank' do
        allow(EventGetter).to receive(:new).with(anything).and_return(whattodo)
        params['datetime'] = ""

        get :index, params

        expect(session['datetime']).to eq(DateTime.now.strftime("%-m/%y"))
      end

      it 'sets an error message if InvalidDate is raised' do
        get :index, params

        expect(flash[:error]).to be_present
      end

      it 'redirects us back if InvalidDate is raised' do
        get :index, params

        expect(response).to redirect_to(referer)
      end
    end
  end
end
