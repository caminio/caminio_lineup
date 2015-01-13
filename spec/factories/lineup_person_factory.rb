FactoryGirl.define do
  factory :lineup_person, class: 'LineupPerson' do
    firstname "manfred"
    
    to_create { |instance| instance.save }

  end
end