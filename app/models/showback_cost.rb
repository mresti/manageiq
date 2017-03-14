class ShowbackCost < ApplicationRecord
  validates :types, :method, :calculations, :presence => true

  def self.seed
    seed_data.each do |con_cost_attributes|
      con_cost_types = con_cost_attributes[:types]
      next if ShowbackCost.find_by(:types => con_cost_types)
      log_attrs = con_cost_attributes.slice(:types, :operations)
      _log.info("Creating consumption cost with parameters #{log_attrs.inspect}")
      _log.info("Creating #{con_cost_types} consumption cost...")
      con_cost_attributes[:operations].each do |con_cost_types_attributes|
        con_conf = create(:types        => con_cost_attributes[:types],
                          :method       => con_cost_types_attributes[:method],
                          :calculations => con_cost_types_attributes[:calculations])
        con_conf.save
      end
      _log.info("Creating #{con_cost_types} consumption cost... Complete")
    end
  end

  def self.seed_file_name
    @seed_file_name ||= Rails.root.join("db", "fixtures", "#{table_name}.yml")
  end
  private_class_method :seed_file_name

  def self.seed_data
    File.exist?(seed_file_name) ? YAML.load_file(seed_file_name) : []
  end
  private_class_method :seed_data
end
