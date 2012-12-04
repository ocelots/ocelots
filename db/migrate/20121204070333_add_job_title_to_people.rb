class AddJobTitleToPeople < ActiveRecord::Migration
  def change
    add_column   :people  ,:job_title , :string
  end
end
