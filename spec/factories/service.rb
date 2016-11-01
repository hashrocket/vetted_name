FactoryGirl.define do
  factory :service do
    factory :twitter_service do
      name 'Twitter'
      job_klass 'CheckTwitterJob'
    end
  end
end
