module JurnalApi
  class Client
    # Defines methods related to Core
    module HealthChecks

      def health_check(params = {})
        response = get('ping/health_check', params, true)
        response
      end
    end
  end
end
