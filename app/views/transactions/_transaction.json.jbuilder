json.extract! transaction, :id, :account_id, :type, :status, :accepted_by, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)