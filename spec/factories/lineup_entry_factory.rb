FactoryGirl.define do
  factory :lineup_entry, class: 'LineupEntry' do
    categories ["one", "two"]

    to_create { |instance| instance.save }

  end
end