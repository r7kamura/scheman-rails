namespace :db do
  namespace :scheman do
    desc "Show diff between the current DB schema and db/schema.sql"
    task diff: [:environment, :load_config] do
      Scheman::Rails::Dumper.call
    end

    desc "Apply diff to the database"
    task apply: [:environment, :load_config] do
      Scheman::Rails::Applier.call
    end
  end
end
