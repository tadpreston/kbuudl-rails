class CreateCredentials < ActiveRecord::Migration[5.2]
  def change
    create_table :credentials do |t|
      t.string :email
      t.string :password_digest
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
