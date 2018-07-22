require 'spec_helper'

describe Forecast do
  subject { Forecast.new(forecast_json: {}.to_json, datetime: DateTime.now) }
  describe "#rain?" do
    context "when the forecast contains the string 'rain'" do
      it "is true" do
        allow(subject).to receive(:forecast).and_return("it's raining")
        expect(subject.rain?).to be true
      end
    end

    context "when the forecast does not contain the string 'rain'" do
      it "is true" do
        allow(subject).to receive(:forecast).and_return("nothing but sun")
        expect(subject.rain?).to be false
      end
    end
  end
end
