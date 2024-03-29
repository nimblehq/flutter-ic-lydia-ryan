class Environments
  def self.CI
    ENV['CI']
  end

  def self.MANUAL_VERSION
    ENV['MANUAL_VERSION']
  end

  def self.FASTLANE_USER
    ENV['FASTLANE_USER']
  end

  def self.APPSTORE_CONNECT_API_KEY
    ENV["APPSTORE_CONNECT_API_KEY"]
  end

  def self.FIREBASE_APP_ID
    ENV["FIREBASE_IOS_APP_ID"]
  end

  def self.FIREBASE_TOKEN
    ENV["FIREBASE_TOKEN"]
  end

  def self.BUILD_NUMBER
    ENV['BUILD_NUMBER']
  end

  def self.APP_STORE_KEY_ID
    ENV['APP_STORE_KEY_ID']
  end

  def self.APP_STORE_ISSUER_ID
      ENV['APP_STORE_ISSUER_ID']
  end
end
