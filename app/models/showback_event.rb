class ShowbackEvent < ApplicationRecord
  belongs_to :showback_configuration

  validates :data,       :presence => true
  validates :start_time, :presence => true
  validates :end_time,   :presence => true
  validates :id_obj,     :presence => true
  validates :type_obj,   :presence => true

  validate :start_time_before_end_time

  def start_time_before_end_time
    if self.start_time > self.end_time
      errors.add(:start_time, "Start time should be before end time")
    end
  end

  serialize :data, JSON # Implement data column as a JSON
  default_value_for(:data) { {} }

  # return the parsing error message if not valid JSON; otherwise nil
  def validate_format
    JSON.parse(data) && nil if content
  rescue JSON::ParserError => err
    err.message
  end
end
