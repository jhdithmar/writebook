class JoinCode
  def self.verify(join_code)
    new(self.class.verify_permissions(join_code))
  end

  def initialize(editable, readable)
    @editable, @readable = editable, readable
  end

  def to_s
    self.class.generate_code(@editable, @readable)
  end

  private
    class << self
      def generate_code(editable, readable)
        verifier.generate([ editable, readable ], purpose: :join_code, expires_in: 2.days)
      end

      def verify_permissions(join_code)
        verifier.verify(join_code, purpose: :join_code)
      end

      def verifier
        ActiveSupport::MessageVerifier.new(secret)
      end

      def secret
        Rails.application.key_generator.generate_key("join_codes")
      end
    end
end
