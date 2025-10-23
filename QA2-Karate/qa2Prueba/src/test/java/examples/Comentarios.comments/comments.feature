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

  @Regresion @PostComments
  Scenario: Crear un nuevo comentario
    Given path '/comments'
    And request commentPayload
    When method post
    Then status 201
    And match response.id == '#number'
    And match response.post_id == 237529
    And match response.name == 'Karthik Mishra'
    And match response.email == 'mishra_karthik@kilback.test'
    And match response.body == 'Cumque veniam velit. Molestias nemo consequuntur. Dicta saepe et.'

  @Regresion @GetAllComments
  Scenario: Obtener todos los comentarios
    Given path '/comments'
    When method get
    Then status 200
    And match response == '#array'
    And match each response[*] ==
      """
      {
        "id": '#number',
        "post_id": '#number',
        "name": '#string',
        "email": '#string',
        "body": '#string'
      }
      """


  @Regresion @PutComments
  Scenario: Actualizar un comentario existente
    Given path '/comments'
    And request commentPayload
    When method post
    Then status 201
    * def commentId = response.id

    * def updatedBody =
      """
      {
        "name": "Karthik Actualizado",
        "body": "Este es el cuerpo del comentario actualizadosadad."
      }
      """

    Given path '/comments', commentId
    And request updatedBody
    When method put
    Then status 200
    And match response.id == commentId
    And match response.name == 'Karthik Actualizado'
    And match response.body == 'Este es el cuerpo del comentario actualizadosadad.'
    And match response.post_id == 237529