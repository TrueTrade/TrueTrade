class Commodity < ActiveRecord::Base
  belongs_to :trade
  #has_many :trades , :dependent => :destroy
end
