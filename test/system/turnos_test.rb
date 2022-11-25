require "application_system_test_case"

class TurnosTest < ApplicationSystemTestCase
  setup do
    @turno = turnos(:one)
  end

  test "visiting the index" do
    visit turnos_url
    assert_selector "h1", text: "Turnos"
  end

  test "should create turno" do
    visit turnos_url
    click_on "New turno"

    fill_in "Estado", with: @turno.estado
    fill_in "Fecha", with: @turno.fecha
    fill_in "Motivo", with: @turno.motivo
    fill_in "Resultado", with: @turno.resultado
    click_on "Create Turno"

    assert_text "Turno was successfully created"
    click_on "Back"
  end

  test "should update Turno" do
    visit turno_url(@turno)
    click_on "Edit this turno", match: :first

    fill_in "Estado", with: @turno.estado
    fill_in "Fecha", with: @turno.fecha
    fill_in "Motivo", with: @turno.motivo
    fill_in "Resultado", with: @turno.resultado
    click_on "Update Turno"

    assert_text "Turno was successfully updated"
    click_on "Back"
  end

  test "should destroy Turno" do
    visit turno_url(@turno)
    click_on "Destroy this turno", match: :first

    assert_text "Turno was successfully destroyed"
  end
end
