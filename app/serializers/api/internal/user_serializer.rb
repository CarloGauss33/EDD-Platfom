class Api::Internal::UserSerializer < ActiveModel::Serializer
  type :assignment

  attributes(
    :id,
    :first_name,
    :full_name,
    :username,
    :email,
    :github_username,
    :university_id,
    :rut,
    :names,
    :last_names
  )
end
