module ProfilesHelper
  def get_user_name(profile)
    profile.name || profile.user.email.split('@').first
  end
end