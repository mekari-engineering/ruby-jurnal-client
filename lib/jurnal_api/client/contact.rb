# frozen_string_literal: true

module JurnalApi
  class Client
    # Defines methods related to Contacts
    module Contacts
      def contacts(params = {})
        get('contacts', params)
      end

      def contact_create(params = {})
        post('contacts', params)
      end

      def contact_update(id, params = {})
        patch("contacts/#{id}", params)
      end

      def contact_find(id)
        get("contacts/#{id}")
      end
    end
  end
end
