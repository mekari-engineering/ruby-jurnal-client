module JurnalApi
  class Client
    # Defines methods related to Contacts
    module Contacts
      def contact_create(params = {})
        response = post('contacts', params)
        response
      end

      def contact_find(id)
        response = get("contacts/#{id}")
        response
      end
    end
  end
end