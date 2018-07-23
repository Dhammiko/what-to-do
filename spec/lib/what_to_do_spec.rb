require 'rails_helper'
class InvalidZip < StandardError; end

describe WhatToDo do
  context "when passed a zipcode" do
    describe "#initialize" do
      it "should raise InvalidZip unless the zipcode argument is 5 digits" do
        expect{ WhatToDo.new({'zipcode' => '1234'}) }.to raise_exception(Exceptions::InvalidZip)
      end
    end

    describe "#get_events" do
      let(:client) { double('event brite client') }
      let!(:event) { double(:event, to_s: "an event") }
      let(:thirty_events) { Array.new(30, event) }
      before do
        allow(EventBriteClient).to receive(:new).and_return(client)
        allow(client).to receive(:events_for).with(anything).and_return(thirty_events)
        allow(Event).to receive(:new).with(anything).and_return(double(load: ''))
      end

      subject { WhatToDo.new({'zipcode' => '90210'}) }
      it "should only fetch up to the max_events" do
        events = subject.get_events
        expect(events.count).to eq(3)
      end
    end
  end

  describe "#initialize" do
    context "when passed an invalid date" do
      it "should raise InvalidDate" do
        expect{ WhatToDo.new({'zipcode' => '12345', 'datetime' => 'pizza'}) }.to raise_exception(Exceptions::InvalidDate)
      end
    end

    context "when missing the date string" do
      it "should return a current DateTime object" do
        expect(DateTime).to receive(:now)

        WhatToDo.new({'zipcode' => '12345', 'datetime' => ""})
      end
    end
  end
end
