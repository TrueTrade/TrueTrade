class Trade < ActiveRecord::Base
  belongs_to :importer, class_name: 'Country', foreign_key: 'importer_code'
  belongs_to :exporter,  class_name: 'Country', foreign_key: 'exporter_code'
  has_one :commodity
end
