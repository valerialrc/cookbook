require 'rails_helper'

feature 'Admin registra categoria' do
  scenario 'com sucesso' do
    admin = create(:user, email: 'admin@email.com',
                          password: '123456', role: :admin)

    login_as admin, scope: :user
    visit new_category_path
    fill_in 'Nome', with: 'Receitas de Natal'
    click_on 'Salvar'

    expect(current_path).to eq categories_path
    expect(page).to have_content 'Categoria cadastrada com sucesso'
    expect(page).to have_content 'Receitas de Natal'
  end

  scenario 'com campos incompletos' do
    admin = create(:user, email: 'admin@email.com',
                          password: '123456', role: :admin)

    login_as admin, scope: :user
    visit new_category_path
    fill_in 'Nome', with: ''
    click_on 'Salvar'

    expect(page).to have_content('Não foi possível cadastrar categoria')
    expect(Category.count).to eq 0
  end

  scenario 'apenas admin' do
    user = create(:user, email: 'user@email.com',
                         password: '123456', role: :user)

    login_as user, scope: :user
    visit new_category_path

    expect(current_path).to eq root_path
  end

  scenario 'precisa estar logado' do
    visit new_recipe_type_path

    expect(current_path).to eq new_user_session_path
  end
end