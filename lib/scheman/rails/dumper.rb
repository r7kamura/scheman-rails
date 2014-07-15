module Scheman
  module Rails
    class Dumper
      COMMAND = "mysqldump"

      def self.call(*args)
        new(*args).call
      end

      # @note You can extract some useful information from @configuration object
      # @param configuration [Object] A configuration object for ActiveRecord
      def initialize(configuration)
        @configuration = configuration
      end

      def call
        system(COMMAND, *options)
      end

      private

      def options
        default_options + additional_options
      end

      def default_options
        [
          database,
          "--compact",
          "--no-data",
        ]
      end

      def additional_options
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
        @configuration["database"]
      end

      def encoding
        @configuration["encoding"]
      end

      def socket
        @configuration["socket"]
      end

      def host
        @configuration["host"]
      end

      def password
        @configuration["password"]
      end

      def port
        @configuration["port"]
      end

      def socket
        @configuration["socket"]
      end

      def username
        @configuration["username"]
      end
    end
  end
end
