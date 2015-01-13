FactoryGirl.define do
  factory :lineup_job, class: 'LineupJob' do
    title "a job"
    description "an interesting one"

    to_create { |instance| instance.save }

  end
end