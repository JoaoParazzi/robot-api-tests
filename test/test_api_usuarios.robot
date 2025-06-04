*** Settings ***
Library    RequestsLibrary

*** Variables ***
${BASE_URL}    https://jsonplaceholder.typicode.com

*** Test Cases ***

Obter Lista de usuários
    [tags]    get
    ${response}=    GET    ${BASE_URL}/users
    Should Be Equal As Integers    ${response.status_code}    200
    Log    ${response.json()}

Criar Novo Post
    [tags]    post
    ${data}=    Create Dictionary    title=Teste Post    body=Conteúdo exemplo    userId=1
    ${response}=    POST    ${BASE_URL}/posts    json=${data}
    Should Be Equal As Integers    ${response.status_code}    201
    ${novo_id}=    Set Variable    ${response.json()['id']}
    Log    Novo ID criado: ${novo_id}

Atualizar Post
    [tags]    put
    ${data}=    Create Dictionary    id=1    title=Atualizado    body=Novo conteúdo    userId=1
    ${response}=    PUT    ${BASE_URL}/posts/1    json=${data}
    Should Be Equal As Integers    ${response.status_code}    200      
    Log    ${response.json()['title']}
    Should Be Equal As Strings    ${response.json()['title']}    Atualizado


Excluir Post
    [tags]    delete
    ${response}=    DELETE    ${BASE_URL}/posts/1
    Should Be Equal As Integers    ${response.status_code}    200
