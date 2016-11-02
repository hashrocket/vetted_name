FactoryGirl.define do
  factory :service do
    factory :domain_service do
      name 'Domain'
      job_klass 'CheckDomainJob'
    end

    factory :twitter_service do
      name 'Twitter'
      job_klass 'CheckTwitterJob'
    end
  end
end
