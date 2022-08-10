module JurnalApi
  class Client
    # Defines methods related to Contacts
    module Contacts
      def contacts(params = {})
        response = get('contacts', params)
        response
      end

      def contact_find(id)
        response = get("contacts/#{id}")
        response
      end
    end
  end
end