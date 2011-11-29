class Browsah
  class Helpers
    class << self
      def normalize_headers(headers)
        Hash[headers.map { |k, v| [k.downcase, v] }]
      end
    end
  end
end
