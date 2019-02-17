# frozen_string_literal: true

require 'rails_helper'

describe 'Packages', type: :request do
  let(:user) { create(:user) }
  let(:package_group) { create(:package_group) }
  let(:package) { create(:package) }

  it 'redirects guests away from the show package page' do
    get package_group_package_path(package_group, package)
    expect(response).to redirect_to(sign_in_path)
  end

  it 'displays the show package page' do
    get package_group_package_path(package_group, package, as: user)
    expect(response).to have_http_status(:ok)
    expect(response).to render_template :show
  end

  it 'redirects guests away from the new page' do
    get new_package_group_package_path(package_group)
    expect(response).to redirect_to(sign_in_path)
  end

  it 'displays the new package page' do
    get new_package_group_package_path(package_group, as: user)
    expect(response).to have_http_status(:ok)
    expect(response).to render_template :new
  end

  it 'redirects guests away from the edit page' do
    get edit_package_group_package_path(package_group, package)
    expect(response).to redirect_to(sign_in_path)
  end

  it 'displays the edit page' do
    get edit_package_group_package_path(package_group, package, as: user)
    expect(response).to have_http_status(:ok)
    expect(response).to render_template :edit
  end

  it 'redirects guests away from the create path' do
    expect do
      post package_group_packages_path(package_group, package: attributes_for(:package))
    end.to_not change(Package, :count)
    expect(response).to redirect_to(sign_in_path)
  end

  it 'fails to create a package with invalid parameters' do
    expect do
      post package_group_packages_path(package_group, package: attributes_for(:package, name: ''), as: user)
    end.to_not change(Package, :count)
    expect(flash[:alert]).to eq(["Name can't be blank"])
    expect(response).to redirect_to(new_package_group_package_path(package_group))
  end

  it 'creates a package with valid parameters' do
    expect do
      post package_group_packages_path(package_group, package: attributes_for(:package, name: 'Test Name'), as: user)
    end.to change(Package, :count).by(1)
    expect(flash[:notice]).to match(/Package was successfully created./)
    expect(response).to redirect_to(package_group_package_path(package_group, Package.last))
  end

  it 'redirects guests away from the update path' do
    expect do
      patch package_group_package_path(package_group, package, package: attributes_for(:package, name: 'Test Name'))
      package.reload
    end.to_not change(package, :name)
    expect(response).to redirect_to(sign_in_path)
  end

  it 'fails to update a package with invalid parameters' do
    expect do
      patch package_group_package_path(package_group, package, package: attributes_for(:package, name: ''), as: user)
      package.reload
    end.to_not change(package, :name)
    expect(flash[:alert]).to eq(["Name can't be blank"])
    expect(response).to redirect_to(edit_package_group_package_path(package_group, package))
  end

  it 'updates a package with valid parameters' do
    expect do
      patch package_group_package_path(package_group, package, package: attributes_for(:package, name: 'Test Name'), as: user)
      package.reload
    end.to change(package, :name)
    expect(flash[:notice]).to match(/Package was successfully updated./)
    expect(response).to redirect_to(package_group_package_path(package_group, package))
  end

  it 'redirects guests from the destroy path' do
    delete package_group_package_path(package_group, package)
    expect(response).to redirect_to(sign_in_path)
  end

  it 'deletes a package' do
    delete package_group_package_path(package_group, package, as: user)
    expect(response).to redirect_to(package_groups_path)
  end
end
