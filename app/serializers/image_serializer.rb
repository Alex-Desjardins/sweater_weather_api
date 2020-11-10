class ImageSerializer
  include FastJsonapi::ObjectSerializer
  # attributes :image_url, :location, :credit
  attribute :image do |object|
    {location: object.location,
     image_url: object.image_url,
     credit: object.credit}
  end
end
