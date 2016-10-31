services = [
  { name: 'Twitter', job_klass: 'CheckTwitterJob' },
  { name: 'Domain', job_klass: 'CheckDomainJob' }
]

for attrs in services
  Service.create(attrs) unless Service.exists?(attrs)
end
