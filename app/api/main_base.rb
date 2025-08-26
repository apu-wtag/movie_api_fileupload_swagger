require 'grape-swagger/entity'
class MainBase < Grape::API
  mount V1::Base
end
