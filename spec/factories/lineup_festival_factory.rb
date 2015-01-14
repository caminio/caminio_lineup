FactoryGirl.define do
  factory :lineup_festival, class: 'LineupFestival' do
    title "a festival"

    to_create { |instance| instance.save }

  end
end