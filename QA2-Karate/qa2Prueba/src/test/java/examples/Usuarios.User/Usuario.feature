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

  @Regresion @PostUser
  Scenario: Crear un nuevo usuario exitosamente
    Given path 'users'
    And request
    """
      {
        "id": 098756,
        "name":"MadMax777",
        "gender":"male",
        "email":"mad.max777@19ce.com",
        "status":"active"
      }
    """

    When method POST
    Then status 201
    And match response.gender == "male"
    And match response.status == "active"

    Given path 'users', userId = 098756
    When method GET
    Then status 200
    And match response.id == userId