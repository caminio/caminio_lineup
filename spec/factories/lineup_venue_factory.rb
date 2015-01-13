FactoryGirl.define do
  factory :lineup_venue, class: 'LineupVenue' do
    opening_hours "7:00-17:00"
    # ext_ref_id "ext_ref_id_000"
    
    to_create { |instance| instance.save }

  end
end