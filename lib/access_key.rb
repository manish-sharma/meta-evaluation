require 'jwt'

class AccessKey

  HMAC_SECRET = ENV["JWT_HMAC_SECRET"]
  EXPIRATION_TIME = Time.now.to_i + ENV["ACCESS_KEY_EXPIRATION_TIME"]

  class << self

    # Get token of payload data
    #
    # @param [Hash] data: data to be kept in token
    # @return [Text] access_key
    # @author Shobhit Dixit
    def get_key(data)
      payload = generate_payload_from data
      JWT.encode payload, HMAC_SECRET, 'HS256'
    end

    # Create initial payload of jwt access_key. ExpiredSignature error
    #
    # @param [Hash] data: payload data
    # @return [Hash] payload for jwt is returned
    # @example
    #  payload {:iat => "2015-12-02T19:32:28.289+05:30", :exp => Time.now.to_i + 1.hour.seconds}
    # @raise ArgumentError if payload data is not a hash
    # @author Shobhit Dixit
    def generate_payload_from(data)
      raise ArgumentError, 'Argument is not a Hash' unless data.is_a? Hash
      # adding issued at and expiry time in the access key payload
      data[:iat] = DateTime.now               # issued at
      data[:exp] = EXPIRATION_TIME            # expiration time
      data
    end

    # Decode jwt access_key and returns its payload data
    # It raise two exceptions:
    #   JWT::VerificationError => when signature is not matched
    #   JWT::ExpiredSignature => when token is expired
    #
    # @param [Text] key: access_key
    # @return [Hash] payload data
    # @author Shobhit Dixit
    def get_data(key)
      data = {}
      begin
        decoded_key = JWT.decode key, HMAC_SECRET, true, { :algorithm => 'HS256' }
        # decoded key is an array
        # example:
        # [{payload_hash},{"alg"=>"HS256"}]
        data = decoded_key.first.symbolize_keys
        # removing issued at and expiry time in the access key payload
        data.delete(:iat)
        data.delete(:exp)
      rescue JWT::VerificationError
      #invalid signature
        raise JWT::VerificationError
      rescue JWT::ExpiredSignature
        raise JWT::ExpiredSignature
      end
      data
    end

    # Check whether access_key has valid signature
    #
    # @param [Text] key: access_key
    # @return [Boolean] true if valid, else false
    # @author Shobhit Dixit
    def valid?(key)
      begin
        data = get_data(key)
      rescue JWT::VerificationError
        return false
      end
      true
    end

    # Check whether access_key is expired or not
    #
    # @param [Text] key: access_key
    # @return [Boolean] true if expired, else false
    # @author Shobhit Dixit
    def expired?(key)
      begin
        data = get_data(token)
      rescue JWT::ExpiredSignature
        return true
      end
      false
    end

    private :generate_payload_from
  end

end
