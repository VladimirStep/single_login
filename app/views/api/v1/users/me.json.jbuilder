json.email @user.email
json.name "#{@user.profile.first_name} #{@user.profile.last_name}"
json.avatar_url (request.protocol + request.host_with_port + @user.profile.avatar.thumb.url)