module JurnalApi
  class Client
    # Defines methods related to SalesOrders
    module JournalEntries

      def journal_entries(params = {})
        response = get('journal_entries', params)
        response
      end

      def journal_entry_find(id)
        response = get("journal_entries/#{id}")
        response
      end

      def journal_entry_create(params = {})
        response = post('journal_entries', params)
        response        
      end

      def journal_entry_update(id, params = {})
        response = patch("journal_entries/#{id}", params)
        response
      end

      def journal_entry_delete(id)
        response = delete("journal_entries/#{id}")
        response
      end

    end
  end
end