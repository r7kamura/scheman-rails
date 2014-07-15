module Scheman
  module Rails
    class Dumper
      SCHEMA_PATH = "db/schema.sql"

      def self.call
        new.call
      end

      def call
        print statements.join("\n\n").rstrip + "\n"
      end

      private

      def statements
        result = []
        result << create_database_statement if has_unknown_database_error?
        result << diff
        result
      end

      def create_database_statement
        "CREATE DATABASE `#{database}`;"
      end

      def diff
        Scheman::Diff.new(
          before: before_schema,
          after: after_schema,
          type: schema_type,
        )
      end

      def dump
        @dump ||= Open3.capture3(command)
      end

      def dump_result
        dump[0]
      end

      def has_dump_error?
        dump[2] != 0
      end

      def dump_error_message
        dump[1]
      end

      def has_unknown_database_error?
        has_dump_error? && /Unknown database/ === dump_error_message
      end

      def before_schema
        if has_unknown_database_error?
          ""
        else
          dump
        end
      end

      def after_schema
        if after_schema_pathname.exist?
          after_schema_pathname.read
        else
          ""
        end
      end

      def after_schema_pathname
        @after_schema_path ||= ::Rails.root.join(SCHEMA_PATH)
      end

      def command
        "mysqldump " + command_options.join(" ")
      end

      def command_options
        default_command_options + additional_command_options
      end

      def default_command_options
        [
          database,
          "--compact",
          "--no-data",
        ]
      end

      def additional_command_options
        result = []
        result.concat(["--default-character-set", encoding]) if encoding
        result.concat(["--host", host]) if host
        result.concat(["--password", password]) if password
        result.concat(["--port", port]) if port
        result.concat(["--socket", socket]) if socket
        result.concat(["--user", username]) if username
        result
      end

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
    end
  end
end
