Feature: Crud para crear usuario

  Background:
    * url 'https://gorest.co.in/public/v2'
    * header Accept = 'application/json'
    * header Content-Type = 'application/json'
    * header Authorization = 'Bearer 700d0c7a86eb84028bf5cd204b11587f812f9d7cd880dc4edbdbd1d407ae9954'
    * def req_headers = {Authorization: 'Bearer 700d0c7a86eb84028bf5cd204b11587f812f9d7cd880dc4edbdbd1d407ae9954'}
  # * def dataGenerator = Java.type('Utils.DataGenerator')
  #* def payload =
  # """
  #{
  # "gender": "male",
  #"status": "active"
  #}
  #"""
  #* payload.name = dataGenerator.geteUserRandom().name
  #* payload.email = dataGenerator.geteUserRandom().email

  @Regresion @PostTodos
  Scenario: Crear un nuevo To-Do
    Given path '/todos'
    And request todoPayload
    When method post
    Then status 201
    And match response.id == '#number'
    And match response.user_id == 8103055
    And match response.title == "Deleniti turbo dolor sunt cubitum sequi aetas."
    And match response.due_on == "2025-09-21T00:00:00.000+05:30"
    And match response.status == "pending"

  @Regresion @GetAllTodos
  Scenario: Obtener una lista de todos los To-Dos
    Given path '/todos'
    When method get
    Then status 200
    And match response == '#array'
    And match each response[*] ==
      """
      {
        "id": '#number',
        "user_id": '#number',
        "title": '#string',
        "due_on": '#string',
        "status": '#string'
      }
      """
