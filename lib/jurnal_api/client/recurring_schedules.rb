module JurnalApi
  class Client
    # Defines methods related to RecurringSchedules
    module RecurringSchedules

      def recurring_schedules_create(params = {})
        response = post('recurring_schedules', params)
        response
      end
    end
  end
end