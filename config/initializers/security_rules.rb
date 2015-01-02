SecurityRule.class_eval do
  def self.all
    SecurityRule.default_rules.flatten
  end
end
