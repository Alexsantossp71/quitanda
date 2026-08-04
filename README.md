# 🥬 Quitanda — App de Hortifrúti (Flutter)

> Aplicativo mobile de quitanda virtual (e-commerce de hortifrúti) com catálogo, carrinho, pedidos e autenticação.

## 📌 Sobre

O **Quitanda** é um aplicativo Flutter completo de compras de hortifrúti: o usuário navega por categorias, adiciona produtos ao carrinho e acompanha seus pedidos. Projeto de estudo desenvolvido para praticar arquitetura, gerenciamento de estado e integração com API.

## ✨ Funcionalidades

- 👤 **Autenticação** — login, cadastro e recuperação de senha
- 🏠 **Catálogo** — produtos organizados por categorias com busca
- 🛒 **Carrinho** — adicionar/remover itens, controle de quantidade
- 📦 **Pedidos** — histórico com status de acompanhamento
- 👤 **Perfil** do usuário
- 💳 Fluxo de pagamento (dialog)
- 🎨 Temas customizados e telas com skeleton loading (shimmer)

## 🛠️ Tecnologias

- **Flutter** (Dart)
- **GetX** — gerenciamento de estado, rotas e injeção de dependência
- **json_serializable / freezed** — modelos tipados
- **HTTP** — integração com API REST

## 🚀 Como executar localmente

```bash
# 1. Clone o repositório
git clone https://github.com/Alexsantossp71/quitanda.git
cd quitanda

# 2. Instale as dependências
flutter pub get

# 3. Execute (emulador ou dispositivo conectado)
flutter run
```

## 📁 Estrutura

```
lib/
├── main.dart                    # Ponto de entrada
├── src/
│   ├── config/                  # Cores, endpoints, chaves de storage
│   ├── models/                  # Modelos (item, carrinho, pedido, usuário...)
│   ├── pages/
│   │   ├── auth/                # Login, cadastro, recuperação
│   │   ├── base/                # Navegação principal (abas)
│   │   ├── home/                # Catálogo e categorias
│   │   ├── cart/                # Carrinho de compras
│   │   ├── orders/              # Pedidos
│   │   ├── product/             # Detalhe do produto
│   │   └── profile/             # Perfil do usuário
│   ├── pages_routes/            # Configuração de rotas
│   └── services/                # HTTP manager, validadores, utilitários
```

## 👤 Autor

**Alexandre Ramos** — [github.com/Alexsantossp71](https://github.com/Alexsantossp71)

## 📄 Status

Projeto de estudo (última atualização: novembro/2022).
