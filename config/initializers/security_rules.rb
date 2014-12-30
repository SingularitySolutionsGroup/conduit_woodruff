SecurityRule.class_eval do
  def self.all
    ([RestrictStudentAccessToFileDownloads, FinancialAidDataRule, SoftDeleteOnlyForSingularityForNow] + SecurityRule.default_rules).flatten
  end
end
