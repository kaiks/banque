json.extract! transaction, :id, :account_id, :transaction_type, :status, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)