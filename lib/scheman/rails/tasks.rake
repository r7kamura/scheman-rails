namespace :db do
  namespace :scheman do
    desc "Show diff between the current DB schema and db/schema.sql"
    task diff: [:environment, :load_config] do
      Scheman::Rails::Dumper.call
    end
  end
end
