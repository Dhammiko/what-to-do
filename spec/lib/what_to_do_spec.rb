require 'rails_helper'

describe WhatToDo do
  context "when passed a zipcode" do
    before do
      allow_any_instance_of(WhatToDo).to receive(:puts)
    end

    describe "#initialize" do
      it "should raise InvalidZip unless the first argument is 5 digits" do
        expect{ WhatToDo.new([1234]) }.to raise_exception(InvalidZip)
      end
    end

    describe "#print_events" do
      let!(:event) { double(:event, to_s: "an event") }

      subject { WhatToDo.new([90210]) }
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
end
