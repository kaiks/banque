json.extract! user, :id, :title, :name, :surname, :birth_date, :city, :country_code, :income_bracket, :password, :created_at, :updated_at
json.url user_url(user, format: :json)