FactoryGirl.define do
  factory :lineup_event, class: 'LineupEvent' do
    starts Date.new()

    to_create { |instance| instance.save }

  end
end