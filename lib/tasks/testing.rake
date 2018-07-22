task :all do
  ['rspec spec', 'rake spec:javascript'].each do |task|
    system("bundle exec #{task}")
  end
end
