FactoryBot.define do
  factory :course do
    name { "Estructura de Datos y Algoritmos" }
    code { "IIC2133" }
    description { "Dijkstra Ohhh Yea" }
    status { :inactive }
    season { :first_semester }
    year { 2023 }
    administrator_email { "email@example.com" }
  end
end
