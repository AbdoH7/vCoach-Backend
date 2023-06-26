CarrierWave.configure do |config|
    if Rails.env.production?
      config.storage = :fog
      config.fog_credentials = {
        provider: 'AWS',
        aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
        aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
        region: ENV['DO_SPACES_REGION'],
        endpoint: "https://#{ENV['DO_SPACES_REGION']}.digitaloceanspaces.com",
        path_style: true
      }
      config.fog_directory = ENV['DO_SPACES_BUCKET']
      config.fog_public = true
      config.fog_attributes = { 'Cache-Control' => 'max-age=31536000' }
      config.fog_use_ssl_for_aws = false
      config.asset_host = ENV['DO_SPACES_ASSET_HOST']
    else
      config.storage = :file
    end
  end
  