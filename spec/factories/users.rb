FactoryBot.define do
  factory :user do
    nickname              {'おにぎり'}
    email                 {'test@example'}
    password              {'test0000'}
    password_confirmation {password}
    last_name             {'おかか'}
    first_name            {'つなまよ'}
    last_name_kana        {'オカカ'}
    first_name_kana       {'ツナマヨ'}
    birth_date            {'1992-04-01'}
  end
end
