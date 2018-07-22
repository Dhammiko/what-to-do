FactoryBot.define do
  factory :forecast, class: OpenStruct do
    rain? false
    to_s "Cloudy with a chance of meatballs"
    to_create {}
  end
end
