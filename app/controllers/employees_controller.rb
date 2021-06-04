class EmployeesController < ApplicationController
  def index
    @empleados = Employee.all
  end
end
