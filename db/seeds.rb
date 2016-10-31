services = [
  { name: 'Twitter', job_klass: 'CheckTwitterJob' }
]

for attrs in services
  Service.create(attrs) unless Service.exists?(attrs)
end
