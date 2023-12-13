require 'rails_helper'

feature 'Admin registra categoria' do
  scenario 'com sucesso' do
    admin = create(:user, email: 'admin@email.com',
                          password: '123456', role: :admin)

    login_as admin, scope: :user
    visit new_category_path
    fill_in 'Nome', with: 'Receitas de Natal'
    click_on 'Salvar'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Categoria registrada com sucesso!'
    expect(page).to have_content 'Receitas de Natal'
  end
end