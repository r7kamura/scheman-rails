module Scheman
  module Rails
    class Applier < Base
      def self.call
        new.call
      end

      def call
        if has_error?
          abort(error_message)
        elsif dumper.result.present?
          puts dumper.result
        end
      end

      private

      def result
        @result ||= Open3.capture3(command, stdin_data: dumper.result)
      end

      def result_message
        result[0]
      end

      def has_error?
        result[2] != 0
      end

      def error_message
        result[1]
      end

      def diff
        dumper.call
      end

      def dumper
        @dumper ||= Scheman::Rails::Dumper.new
      end

      def command
        "mysql " + command_options.join(" ")
      end

      def has_database?
        !dumper.has_unknown_database_error?
      end

      def command_options
        result = []
        result.concat([database]) if has_database?
        result.concat(["--host", host]) if host
        result.concat(["--password", password]) if password
        result.concat(["--port", port]) if port
        result.concat(["--socket", socket]) if socket
        result.concat(["--user", username]) if username
        result
      end
    end
  end
end
