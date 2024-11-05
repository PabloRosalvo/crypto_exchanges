# crypto_exchanges

## Descrição

O Exchange List é uma aplicação móvel desenvolvida para exibir uma lista de exchanges, permitindo que os usuários filtrem e pesquisem exchanges com base em critérios como rank, nome e ID. O objetivo principal é fornecer uma interface simples e eficiente para visualizar e explorar informações detalhadas sobre exchanges, priorizando as mais confiáveis.

## Funcionalidades
Exibição da lista de exchanges, com destaque inicial para as exchanges mais confiáveis (rank 1).
Filtros dinâmicos através de switches para rank e uma barra de pesquisa para nome e ID.
Navegação intuitiva para acessar os detalhes de cada exchange.

Tecnologias Utilizadas
Linguagem: Swift
Arquitetura: MVVM-C (Model-View-ViewModel-Coordinator)
Frameworks:
RxSwift e RxCocoa para programação reativa.
Kingfisher para carregamento de imagens.
UIKit (ViewCode) para construção da interface.
Quick e Nimble para testes unitários.
URLSession para requisições de rede.
String Catalog para gerenciamento de strings.

## Arquitetura e Benefícios

A arquitetura MVVM-C reativa com RxSwift oferece uma solução modular e escalável, garantindo que o código seja fácil de manter e testar. A separação de responsabilidades entre Model, ViewModel e Coordinator, combinada com bindings reativos, permite que a interface do usuário reaja automaticamente às mudanças de estado, proporcionando uma experiência de usuário fluida e eficiente.

O projeto utiliza inputs e outputs para organizar o fluxo de dados entre as camadas da arquitetura MVVM. Essa abordagem, combinada com programação reativa e o uso de Coordinator para controle de navegação, garante que a comunicação entre as camadas seja clara, eficiente e desacoplada.	

Cobertura de Testes: O projeto possui quase 100% de cobertura de testes nas classes principais, garantindo alta qualidade e testabilidade.
Arquitetura Organizada: O projeto segue uma arquitetura MVVM-C bem definida, com clara separação de responsabilidades, facilitando a manutenção e escalabilidade.
Programação Reativa: Utilização de RxSwift para garantir uma interface reativa e fluida, com inputs e outputs bem definidos entre as camadas.
Testes Simples e Eficazes: Uso de Quick e Nimble para testes fáceis de entender, mesmo para iniciantes.

## Instalação
### Pré-requisitos:
- **Version 15.4 (16B40)** 
- **iOS 13.0** ou superior
- **Cocoapods** 

### Simplicidade para baixar e rodar o projeto:
1. **Baixar o projeto**: O download do projeto é simples e rápido. Basta seguir os comandos abaixo.
2. **Configuração fácil**: O projeto está pronto para ser rodado com um simples comando, tornando a instalação descomplicada.
3. **Compatibilidade**: O projeto foi desenvolvido e testado para funcionar com o Xcode 15.4 e iOS 13 garantindo uma experiência fluida.

### Clonando o Repositório
1. git clone https://github.com/PabloRosalvo/crypto_exchanges.git
2. rodar pod install


### Imagem abaixo é ilustrando os testes e cobertura 

![Uploading Captura de Tela 2024-11-04 às 12.40.54.png…]()


### Video abaixo é o fluxo de forma simples


https://github.com/user-attachments/assets/db5e8138-7fb2-43e4-90cc-fb9afa7811d9



https://github.com/user-attachments/assets/581644d6-c6ee-4a84-ad26-bda654484a79



https://github.com/user-attachments/assets/9cd7ae9b-312f-46ce-af4b-8aadb0264d3b

