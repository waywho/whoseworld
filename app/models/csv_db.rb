# https://stackoverflow.com/questions/7754896/import-csv-data-in-a-rails-app-with-activeadmin

require 'csv'

class CsvDb
  class << self
    def convert_save(model_name, csv_data)
      csv_file = csv_data.read
      upload_count = 0
      CSV.parse(csv_file, headers: true) do |row|
        target_model = model_name.classify.constantize

        data = row.to_h.transform_keys do |k|
          k.underscore.gsub(" ", "_")
        end.slice(*target_model.column_names)

        new_object = target_model.find_or_initialize_by(email: data[:email])
        new_object.assign_attributes(**data)
        upload_count += 1 if new_object.save
      end
      upload_count
    end
  end
end
