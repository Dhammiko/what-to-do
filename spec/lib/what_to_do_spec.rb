require 'rails_helper'
class InvalidZip < StandardError; end

describe WhatToDo do
  context "when passed a zipcode" do
    describe "#initialize" do
      it "should raise InvalidZip unless the zipcode argument is 5 digits" do
        expect{ WhatToDo.new({'zipcode' => '1234'}) }.to raise_exception(Exceptions::InvalidZip)
      end
    end

    describe "#print_events" do
      let!(:event) { double(:event, to_s: "an event") }

      subject { WhatToDo.new({'zipcode' => '90210'}) }
      it "should call get_events" do
        expect_any_instance_of(WhatToDo).to receive(:get_events).and_return([event])
        subject.print_events
      end

      it "should call to_s on events it receives" do
        allow_any_instance_of(WhatToDo).to receive(:get_events).and_return([event])
        expect(event).to receive(:to_s)
        subject.print_events
      end

      let(:six_events) { Array.new(30, event) }
      it "should only print up to the max_events" do
        allow_any_instance_of(WhatToDo).to receive(:get_events).and_return(six_events)
        expect(event).to receive(:to_s).exactly(25).times
        subject.print_events
      end
    end
  end

  context "when passed an invalid date" do
    describe "#initialize" do
      it "should raise InvalidDate" do
        expect{ WhatToDo.new({'zipcode' => '12345', 'datetime' => 'pizza'}) }.to raise_exception(Exceptions::InvalidDate)
      end
    end
  end
end
