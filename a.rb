# frozen_string_literal: true

require 'faraday'
require 'zip'
require 'caracal'
# API Clientt
class ApiClient
  API_URL = 'https://6418014ee038c43f38c45529.mockapi.io'

  def initialize
    @conn = Faraday.new(url: API_URL)
  end

  def all_users
    response = @conn.get('/api/v1/users', { active: true })
    JSON.parse(response.body)
  rescue Faraday::Error => e
    e.response.nil? ? e.message : e.response[:status]
  end

  def get_user_by_id(id)
    response = @conn.get("/api/v1/users/#{id}")
    JSON.parse(response.body)
  rescue Faraday::Error => e
    e.response.nil? ? e.message : e.response[:status]
  end

  def create_user(user)
    response = @conn.post do |req|
      req.url '/api/v1/users'
      req.headers['Content-Type'] = 'application/json'
      req.body = JSON.generate(user)
    end
    JSON.parse(response.body)
  rescue Faraday::Error => e
    e.response.nil? ? e.message : e.response[:status]
  end

  def delete_user(id)
    response = @conn.delete("/api/v1/users/#{id}")
    JSON.parse(response.body)
  rescue Faraday::Error => e
    e.response.nil? ? e.message : e.response[:status]
  end

  def update_user_status(id)
    response = @conn.put("/api/v1/users/#{id}", JSON.generate({ active: true }))
    JSON.parse(response.body)
  rescue Faraday::Error => e
    e.response.nil? ? e.message : e.response[:status]
  end
end

# Export to docs class
class ExportService
  attr_accessor :value, :filename

  def initialize(value, filename = 'result.docx')
    @value = value
    @filename = filename

    validate_value
  end

  def export_to_doc
    Caracal::Document.save(@filename) do |docx|
      build_header(docx)
      build_body(docx)
    end
  end

  private

  def build_header(docx)
    docx.h1 'USERS IN API'
    docx.hr
  end

  def build_body(docx)
    docx.h2 'This is my data'
    row = [['ID', 'Name', 'Gender', 'Avatar', 'Created At']]
    @value.each do |i|
      row << [i['id'], i['name'], i['sex'], i['avatar'], i['created_at']]
    end

    docx.table row do
      cell_style rows[0], background: '3366cc', color: 'ffffff', bold: true
      border_color   '666666'
      border_line    :single
    end
  end

  def validate_value
    raise ArgumentError, 'Value must be an Array' unless @value.is_a? Array
    raise ArgumentError, 'Filename must be a String' unless @filename.is_a? String
  end
end

# Zip file class
class ZipService
  attr_accessor :input_filenames, :filename

  def initialize(*args)
    @filename = args.shift
    @input_filenames = args.flatten

    validate_input
  end

  def zip_file
    folder = Dir.pwd
    zipfile_name = "#{folder}/#{@filename}.zip"
    Zip::File.open(zipfile_name, create: true) do |zipfile|
      @input_filenames.each do |file|
        zipfile.add(file, File.join(folder, file)) if File.exist?(File.join(folder, file))
      end
    end
  end

  private

  def validate_input
    raise ArgumentError, 'Invalid Filename' unless (@filename.is_a? String) && !@filename.empty?

    unless (@input_filenames.is_a? Array) && @input_filenames.all? do |fn|
             fn.is_a?(String) && !fn.empty?
           end
      raise ArgumentError,
            'Invalid Input Filenames'
    end
  end
end

# Example usage

# # GET API Data
# api_client = ApiClient.new
# new_user = { name: 'John', sex: 'Male', avatar: 'https://example.com/avatar.png' }
# created_user = api_client.create_user(new_user)
# users = api_client.all_users
# updated_user = api_client.update_user_status(created_user['id'])
# api_client.delete_user(updated_user['id'])

# # Export to doc file
# export_service = ExportService.new(users, 'a.docx')
# export_service.export_to_doc

# # Zip files
# zip_service = ZipService.new('newzip6', 'Gemfile')
# zip_service.zip_file
