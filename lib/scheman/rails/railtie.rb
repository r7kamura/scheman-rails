module Scheman
  module Rails
    class Railtie < ::Rails::Railtie
      rake_tasks do
        load "scheman/rails/tasks.rake"
      end
    end
  end
end
