module JurnalApi
  class Client
    # Defines methods related to Core
    module Cores

      def health_check(params = {})
        response = get('core/ping/health_check', params)
        response
      end
    end
  end
end
