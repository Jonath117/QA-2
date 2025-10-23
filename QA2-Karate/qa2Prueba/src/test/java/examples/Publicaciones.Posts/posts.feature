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

  @Regresion @PostforPosts
  Scenario: Crud para crear post

    * def posts = read('posts_data.json')
    * def post = posts[0]
    Given path '/posts'
    And request post
    When method post
    Then status 201
    And match response.id == '#number'
    And match response.user_id == post.user_id
    And match response.title == post.title
    And match response.body == post.body

  @Regresion @GetAllPosts
  Scenario: Obtener una lista de todos los posts

    Given path '/posts'
    When method get
    Then status 200
    And match response == '#[10]'
    And match each response[*] ==
      """
      {
        "id": '#number',
        "user_id": '#number',
        "title": '#string',
        "body": '#string'
      }
      """
