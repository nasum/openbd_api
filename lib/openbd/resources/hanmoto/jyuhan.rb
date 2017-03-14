module OpenBD
  module Resources
    class Hanmoto
      class Jyuhan < BaseResource
        def initialize(src)
          super
        end

        def date
          src["date"]
        end

        def comment
          src["comment"]
        end

        def ctime
          src["ctime"]
        end

        def suri
          src["suri"]
        end
      end
    end
  end
end

