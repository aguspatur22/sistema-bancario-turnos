require "application_system_test_case"

class SucursalesTest < ApplicationSystemTestCase
  setup do
    @sucursal = sucursales(:one)
  end

  test "visiting the index" do
    visit sucursales_url
    assert_selector "h1", text: "Sucursales"
  end

  test "should create sucursal" do
    visit sucursales_url
    click_on "New sucursal"

    fill_in "Direccion", with: @sucursal.direccion
    fill_in "Nombre", with: @sucursal.nombre
    fill_in "Telefono", with: @sucursal.telefono
    click_on "Create Sucursal"

    assert_text "Sucursal was successfully created"
    click_on "Back"
  end

  test "should update Sucursal" do
    visit sucursal_url(@sucursal)
    click_on "Edit this sucursal", match: :first

    fill_in "Direccion", with: @sucursal.direccion
    fill_in "Nombre", with: @sucursal.nombre
    fill_in "Telefono", with: @sucursal.telefono
    click_on "Update Sucursal"

    assert_text "Sucursal was successfully updated"
    click_on "Back"
  end

  test "should destroy Sucursal" do
    visit sucursal_url(@sucursal)
    click_on "Destroy this sucursal", match: :first

    assert_text "Sucursal was successfully destroyed"
  end
end
