FactoryBot.define do
  factory :config_variable do
    name { "MyString" }
    key { "my_key" }
    value_type { :string }
    value { "MyString" }
    description { "MyString" }
  end
end
