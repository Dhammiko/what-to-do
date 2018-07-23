FactoryBot.define do
  factory :forecast, class: OpenStruct do
    rain? false
    forecast 'sunny'
    to_create {}
  end
end
