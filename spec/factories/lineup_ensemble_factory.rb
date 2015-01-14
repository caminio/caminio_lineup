FactoryGirl.define do
  factory :lineup_ensemble, class: 'LineupEnsemble' do
    title "an ensemble"

    to_create { |instance| instance.save }

  end
end