# frozen_string_literal: true

require 'rails_helper'

describe EventsController do
  describe 'GET index' do
    let(:params) { { 'zipcode' => '90210' } }
    let(:event) { double('event') }
    let(:whattodo) { double }

    context 'events are found' do
      before do
        allow(WhatToDo::EventGetter).to receive(:new).with(anything).and_return(whattodo)
        allow(whattodo).to receive_messages(get_events: [event])
      end

      it 'assigns @events' do
        get :index, params

        expect(assigns(:events)).to eq([event])
      end
    end

    let(:referer) { '/' }
    context 'invalid zipcodes' do
      let(:params) { { 'zipcode' => '1234' } }

      before { request.env['HTTP_REFERER'] = referer }

      it 'sets an error message if InvalidZip is raised' do
        get :index, params

        expect(flash[:error]).to be_present
      end

      it 'sets an error message if InvalidZip is raised' do
        get :index, params

        expect(response).to redirect_to(referer)
      end
    end

    context 'invalid dates' do
      let(:params) { { 'zipcode' => '12345', 'datetime' => 'pizza' } }
      before { request.env['HTTP_REFERER'] = referer }

      it 'sets an error message if InvalidDate is raised' do
        get :index, params

        expect(flash[:error]).to be_present
      end

      it 'sets an error message if InvalidZip is raised' do
        get :index, params: params

        expect(response).to redirect_to(referer)
      end
    end
  end
end
