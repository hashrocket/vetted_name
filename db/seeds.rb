services = [
  { name: 'Twitter', job_klass: 'CheckTwitterJob' },
  { name: 'Domain', job_klass: 'CheckDomainJob' },
  { name: 'Facebook', job_klass: 'CheckFacebookJob' }
]

for attrs in services
  Service.create(attrs) unless Service.exists?(attrs)
end
