class AddRankingToSentences < ActiveRecord::Migration[7.0]
  def change
    add_column :sentences, :ranking, :integer
  end
end
