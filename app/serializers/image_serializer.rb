class ImageSerializer
  include FastJsonapi::ObjectSerializer
  set_id :id
  attributes :image
end
