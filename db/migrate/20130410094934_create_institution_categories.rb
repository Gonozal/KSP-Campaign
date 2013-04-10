class CreateInstitutionCategories < ActiveRecord::Migration
  def change
    create_table :institution_categories do |t|

      t.timestamps
    end
  end
end
