json.email @user.email
if @user.profile
  json.profile do
    json.(@user.profile, :first_name, :last_name, :gender, :birth_date, :street, :city, :country)
    json.avatar_url (request.protocol + request.host_with_port + @user.profile.avatar.thumb.url)
  end
end