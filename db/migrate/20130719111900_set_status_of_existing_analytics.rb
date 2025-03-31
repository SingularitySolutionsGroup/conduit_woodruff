class SetStatusOfExistingAnalytics < ActiveRecord::Migration
  def change
    Analytic.where(user_action: Analytic.begin_form).each do |analytic|
      analytic.status = Analytic.processed
      analytic.save
    end
  end
end