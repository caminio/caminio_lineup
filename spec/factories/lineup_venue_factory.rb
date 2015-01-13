FactoryGirl.define do
  factory :lineup_venue, class: 'LineupVenue' do
    opening_hours "7:00-17:00"

    to_create { |instance| instance.save }

  end
end