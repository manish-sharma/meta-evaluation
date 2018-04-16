module CustomExceptions
  class AuthenticationError < StandardError; end
  class NoCurrentUser < AuthenticationError; end
end
