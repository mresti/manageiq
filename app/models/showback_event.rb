class ShowbackEvent < ApplicationRecord
  belongs_to :showback_configuration

  validates :data,       :presence => true
  validates :start_time, :presence => true
  validates :end_time,  :presence => true
  validates :id_obj,     :presence => true
  validates :type_obj,   :presence => true

  serialize :data, JSON # Implement data column as a JSON
  default_value_for(:data) { {} }
end
