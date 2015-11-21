class ChangePinItToPinIdInVotesTable < ActiveRecord::Migration
  def change
    rename_column :votes, :pin_it, :pin_id
  end
end
