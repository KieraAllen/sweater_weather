class UserSerializer
  include FastJsonapi::ObjectSerializer
  set_id :id
  attributes :email,
             :api_key
end
