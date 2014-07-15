module Scheman
  module Rails
    class Base
      SCHEMA_PATH = "db/schema.sql"

      def self.call
        new.call
      end

      private

      def database
        configuration["database"]
      end

      def encoding
        configuration["encoding"]
      end

      def socket
        configuration["socket"]
      end

      def host
        configuration["host"]
      end

      def password
        configuration["password"]
      end

      def port
        configuration["port"]
      end

      def socket
        configuration["socket"]
      end

      def username
        configuration["username"]
      end

      def schema_type
        case configuration["adapter"]
        when "mysql2"
          "mysql"
        else
          raise
        end
      end

      def configuration
        @configuration ||= ActiveRecord::Tasks::DatabaseTasks.current_config
      end

      def after_schema_pathname
        @after_schema_path ||= ::Rails.root.join(SCHEMA_PATH)
      end
    end
  end
end
