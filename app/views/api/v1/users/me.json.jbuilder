json.email @user.email
if @user.profile
  json.name "#{@user.profile.first_name} #{@user.profile.last_name}"
  json.avatar_url (request.protocol + request.host_with_port + @user.profile.avatar.thumb.url)
end