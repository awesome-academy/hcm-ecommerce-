namespace :db do
  desc "Remake db"
  task remake_db: :environment do
    ["db:drop", "db:create", "db:migrate", "db:seed"].each do |task|
      Rake::Task[task].invoke
    end
  end
end
