module Scheman
  module Rails
    module Errors
      class Base < StandardError
      end

      class UnexpectedDumpError < Base
      end
    end
  end
end
