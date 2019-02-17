# frozen_string_literal: true

require 'rails_helper'

describe 'Package Groups', type: :request do
  let(:user) { create(:user) }
  let(:package_group) { create(:package_group) }

  it 'redirects guests away from the new path' do
    get new_package_group_path
    expect(response).to redirect_to(sign_in_path)
  end

  it 'displays the new package group page' do
    get new_package_group_path(as: user)
    expect(response).to have_http_status(:ok)
    expect(response).to render_template :new
  end

  it 'redirects guests away from the edit page' do
    get edit_package_group_path(package_group)
    expect(response).to redirect_to(sign_in_path)
  end

  it 'displays the edit package group page' do
    get edit_package_group_path(package_group, as: user)
    expect(response).to have_http_status(:ok)
    expect(response).to render_template :edit
  end

  it 'redirects guests away from the update path' do
    expect do
      post package_groups_path(package_group: attributes_for(:package_group, name: ''))
    end.to_not change(PackageGroup, :count)
    expect(response).to redirect_to(sign_in_path)
  end

  it 'fails to create a package group with invalid parameters' do
    expect do
      post package_groups_path(package_group: attributes_for(:package_group, name: ''), as: user)
    end.to_not change(PackageGroup, :count)
    expect(flash[:alert]).to eq(["Name can't be blank"])
    expect(response).to redirect_to(new_package_group_path)
  end

  it 'creates a package group with valid parameters' do
    expect do
      post package_groups_path(package_group: attributes_for(:package_group), as: user)
    end.to change(PackageGroup, :count).by(1)
    expect(flash[:notice]).to match(/Package group was successfully created./)
    expect(response).to redirect_to(package_groups_path)
  end

  it 'redirects guests away from the update path' do
    expect do
      patch package_group_path(package_group, package_group: attributes_for(:package_group, name: 'Test Group'))
      package_group.reload
    end.to_not change(package_group, :name)
    expect(response).to redirect_to(sign_in_path)
  end

  it 'fails to create a package group with invalid parameters' do
    expect do
      patch package_group_path(package_group, package_group: attributes_for(:package_group, name: ''), as: user)
      package_group.reload
    end.to_not change(package_group, :name)
    expect(flash[:alert]).to eq(["Name can't be blank"])
    expect(response).to redirect_to(edit_package_group_path(package_group))
  end

  it 'updates a package group with valid parameters' do
    expect do
      patch package_group_path(package_group, package_group: attributes_for(:package_group, name: 'Test Group'), as: user)
      package_group.reload
    end.to change(package_group, :name)
    expect(flash[:notice]).to match(/Package group was successfully updated./)
    expect(response).to redirect_to(package_groups_path)
  end

  it 'redirects guests from the destroy path' do
    delete package_group_path(package_group)
    expect(response).to redirect_to(sign_in_path)
  end

  it 'destroys the package group' do
    delete package_group_path(package_group, as: user)
    expect(response).to redirect_to(package_groups_path)
  end
end
