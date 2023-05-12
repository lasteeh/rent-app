module UserRegistration
  module TokenGenerator
    extend ActiveSupport::Concern

    included do
      # callback
      before_create :generate_token

      # authorization
      def generate_token
        self.token = Digest::SHA1.hexdigest([Time.now, rand(111..999)].join)
      end
    end
  end
end
