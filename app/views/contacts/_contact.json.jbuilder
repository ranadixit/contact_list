json.extract! contact, :id, :name, :email, :phone_number
json.url contact_url(contact, format: :json)