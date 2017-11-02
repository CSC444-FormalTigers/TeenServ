CarrierWave.configure do |config|

  # Use local storage if in development or test
  if Rails.env.development? || Rails.env.test?
    CarrierWave.configure do |config|
      config.storage = :file
    end
  end

  # Use AWS storage if in production
  if Rails.env.production?
    CarrierWave.configure do |config|
      config.storage = :fog
    end
  end

  config.fog_credentials = {
    :provider               => 'AWS',                             # required
    :aws_access_key_id      => 'AKIAJ7WIXBXGS2V33LVQ',            # required
    :aws_secret_access_key  => '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',     # required
    :region                 => 'eu-east-2'                        # optional, defaults to 'us-east-1'
  }
  config.fog_directory  = 'teenserv'               # required
  #config.fog_host       = 'https://assets.example.com'           # optional, defaults to nil
  #config.fog_public     = false                                  # optional, defaults to true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end
