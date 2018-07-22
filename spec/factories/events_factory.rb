FactoryBot.define do
  factory :event, class: OpenStruct do
    to_s "a cool event"
    to_create {}
  end
end
