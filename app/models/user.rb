# This class is used to set current_user
class User
   @@current_user = nil

   def self.set_current_user(user)
     raise CustomExceptions::NoCurrentUser, "Current User is not present" unless user.present?
     @@current_user = user
   end

   def self.current_user
     @@current_user
   end

end
