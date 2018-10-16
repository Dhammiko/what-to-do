require 'rails_helper'

describe EventGetter do
  context 'when passed a zipcode' do
    describe '#initialize' do
      it 'should raise InvalidZip unless the zipcode argument is 5 digits' do
        expect { EventGetter.new('zipcode' => '1234') }.to raise_exception(Exceptions::InvalidZip)
      end
    end

    describe '#get_events' do
      let(:client) { double('event brite client') }
      let!(:event) { double('vent', load: 'an event') }
      let(:thirty_events) { Array.new(30, event) }
      before do
        allow_any_instance_of(EventGetter).to receive(:event_brite_client).and_return(client)
        allow(client).to receive(:events_for).with(anything).and_return(thirty_events)
        allow(Event).to receive(:new).with(anything).and_return(double(load: 'loaded event'))
      end

      subject { EventGetter.new('zipcode' => '90210') }

      it 'should not raise if the client returns bad data' do
        allow(client).to receive(:events_for).with(anything).and_return(nil)

        expect { subject.get_events }.to_not raise_error
      end
    end
  end

  describe '#initialize' do
    context 'when passed an invalid date' do
      it 'should raise InvalidDate' do
        expect { EventGetter.new('zipcode' => '12345', 'datetime' => 'pizza') }.to raise_exception(Exceptions::InvalidDate)
      end
    end

    context 'when missing the date string' do
      it 'should return a current DateTime object' do
        expect(DateTime).to receive(:now)

        EventGetter.new('zipcode' => '12345', 'datetime' => '')
      end
    end
  end
end
