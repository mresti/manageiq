class Showback < ApplicationRecord
  belongs_to :showback_configuration

  validates :data,       :presence => true
  validates :event_init, :presence => true
  validates :event_end,  :presence => true
  validates :id_obj,     :presence => true
  validates :type_obj,  :presence => true

  serialize :data, JSON # Implement data column as a JSON
  default_value_for(:data) { {} }
end
