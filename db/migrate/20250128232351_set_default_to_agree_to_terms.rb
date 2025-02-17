class SetDefaultToAgreeToTerms < ActiveRecord::Migration[7.2]
  def change
    change_column :burm_people, :agree_to_terms, :boolean, default: true
  end
end
