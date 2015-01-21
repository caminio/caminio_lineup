FactoryGirl.define do
  factory :mediafile, class: 'Mediafile' do
    description "a mediafile"

    to_create { |instance| instance.save }

  end
end
