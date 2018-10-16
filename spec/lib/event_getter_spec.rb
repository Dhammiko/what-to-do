require 'rails_helper'

describe EventGetter do
  context 'when passed a zipcode' do
    describe '#initialize' do
      it 'should raise InvalidZip unless the zipcode argument is 5 digits' do
        expect { EventGetter.new({zipcode: '1234', datetime: '10/10'}) }.to raise_exception(Exceptions::InvalidZip)
      end
    end

    describe '#get_events' do
      let(:client) { double('event brite client') }
      let(:event) { double('event', load: 'an event') }
      let(:events) { [event] }
      before do
        allow(subject).to receive(:eventbrite_events).and_return(events)
        allow(Event).to receive(:new).with(anything).and_return(event)
      end

      subject { EventGetter.new({zipcode: '90210', datetime: '10/10'}) }

      it 'should not raise if the client returns bad data' do
        allow(client).to receive(:events_for).with(anything).and_return(nil)

        expect { subject.get_events }.to_not raise_error
      end

      it 'should call load on event objects' do
        allow(Thread).to receive(:new).and_yield
        expect(event).to receive(:load)

        subject.get_events
      end
    end
  end

  describe '#initialize' do
    context 'when passed an invalid date' do
      it 'should raise InvalidDate' do
        expect { EventGetter.new({zipcode: '12345', datetime: 'pizza'}) }.to raise_exception(Exceptions::InvalidDate)
      end
    end
  end
end
