# simple_simple_todo

Simple To-Do app, consumindo a api do https://dummyjson.com/docs/todos

utilizei o Sqflite para a persistência local, me baseei na arquitetura do Clean
Arch do Reso Coder, seguindo a estrutura de pastas proposta.

Além do uso de padrões do SOLID e Design Pattenrs que são padrões utilizados e
propost no Clean Arch (nem tudo foi seguido 100% a risca).

Para rodar o projeto, é preciso estar com o Flutter na versão 3.27.4,
seguir os seguintes passo a passo:

- Entrar na pasta raiz do projeto, rodar o comando flutter pub get para atualizar dependencias;
- Para rodar o projeto, utilizar o flutter run dentro da raiz do projeto ou utilizar o 
launch.json e rodar direto no vsCode;
- De preferência utilizar um celular ou emulador para rodar o app
- Ter certeza de que o android studio ou xCode está atualizado

# O que eu pretendo evoluir nesse projeto

- Bom, eu criaria os temas de forma mais organizada, para facilitar o acesso aos
estilos de texto, utilizando talvez o themeExtensions.

- Também padronizaria os espaçamentos, de forma que eu so acesssa-se os valores necessários,
mas pra isso teria que ter Design system em um figma.

- Melhorar as animações, principalmente para tarefas finalizadas e botões, 
responsividade e até mesmo como o estado está sendo gerenciado,o ideal é que
 não precisa-se recarregar as listas todas para ver o que foi modificado.
- Algumas refatorações, principalmente no ToDo repository, no caso, a implementação dele;
- deixaria menos acoplado o ToDo que foi selecionado, talvez um selected ToDo dentro da Store.

- Criaria o restante dos testes e verificaria a cobertura de testes

-  Os testes que criei foram os da Store e o do Repository, utilizei o mocktail para fazer os mocks.

- Outras melhorias envolvendo design, principalmente a questão de fidelidade do Design, 
faltou alguns ajustes.
