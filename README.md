# 🥬 Quitanda — App de Hortifrúti (Flutter)

[![Flutter](https://img.shields.io/badge/Flutter-3.27+-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.6+-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![GetX](https://img.shields.io/badge/GetX-State%20Management-red?logo=getx&logoColor=white)](https://github.com/jonataslaw/getx)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![CI](https://img.shields.io/badge/CI-GitHub%20Actions-success?logo=github&logoColor=white)](https://github.com/Alexsantossp71/quitanda/actions)

> Aplicativo Flutter completo de compras de hortifrúti com arquitetura limpa, gerenciamento de estado profissional e separação de responsabilidades.

## 📸 Screenshots

| Login | Catálogo | Carrinho | Pedidos |
|------|----------|----------|---------|
| ![Login](assets/screenshots/login.png) | ![Catálogo](assets/screenshots/catalog.png) | ![Carrinho](assets/screenshots/cart.png) | ![Pedidos](assets/screenshots/orders.png) |

> **Nota**: Adicione prints de tela na pasta `assets/screenshots/` para substituir os placeholders acima.

## ✨ Funcionalidades

### 🔐 Autenticação
- Login com e-mail e senha
- Cadastro de novos usuários
- Recuperação de senha

### 🛒 Catálogo de Produtos
- Produtos organizados por categorias (Frutas, Legumes, Verduras, Orgânicos)
- Busca inteligente por nome
- Detalhes do produto com preço unitário e unidade de medida

### 🛍️ Carrinho de Compras
- Adicionar e remover itens
- Controle de quantidade (+/-)
- Cálculo automático do total
- Persistência local dos itens

### 📦 Pedidos
- Finalização de pedido com fluxo de pagamento (dialog)
- Histórico de pedidos com status de acompanhamento
- Detalhes do pedido (itens, quantidades, valores)

### 👤 Perfil do Usuário
- Edição de dados pessoais
- Gerenciamento de endereços

### 🎨 UX/UI
- Temas customizados (claro/escuro)
- Skeleton loading (shimmer) em carregamentos
- Navegação por abas (bottom navigation)
- Transições de página suaves

## 🏗️ Arquitetura

```
┌─────────────────────────────────────────────────┐
│                   Flutter App                    │
├─────────────────────────────────────────────────┤
│  Pages (UI Layer)                               │
│  ├── auth/      → Login, Cadastro, Recuperação  │
│  ├── home/      → Catálogo, Categorias, Busca   │
│  ├── cart/      → Carrinho, Itens, Total       │
│  ├── orders/    → Histórico, Detalhes, Status   │
│  ├── product/   → Detalhe do Produto             │
│  └── profile/   → Perfil do Usuário              │
├─────────────────────────────────────────────────┤
│  Controllers (Business Logic — GetX)            │
│  ├── AuthController      → Autenticação         │
│  ├── CartController      → Estado do carrinho   │
│  ├── OrderController     → Gerência de pedidos  │
│  └── ProductController    → Catálogo e busca     │
├─────────────────────────────────────────────────┤
│  Models (Data Layer — freezed + json_serializable)│
│  ├── Item             → Produto do catálogo     │
│  ├── CartItem         → Item no carrinho        │
│  ├── Order            → Pedido completo         │
│  └── AppUser          → Usuário autenticado     │
├─────────────────────────────────────────────────┤
│  Data Sources                                  │
│  ├── HTTP (REST API) → Integração com backend  │
│  └── Local Storage   → Preferências e cache     │
└─────────────────────────────────────────────────┘
```

## 🛠️ Tecnologias

| Tecnologia | Uso |
|---|---|
| **Flutter 3.27+** | Framework cross-platform |
| **Dart 3.6+** | Linguagem principal |
| **GetX** | Gerenciamento de estado, rotas e injeção de dependência |
| **json_serializable** | Serialização JSON dos modelos |
| **freezed** | Modelos imutáveis com `copyWith` |
| **http** | Integração com API REST |
| **shared_preferences** | Persistência local |

## 🚀 Como Executar Localmente

### Pré-requisitos
- [Flutter SDK](https://flutter.dev/docs/get-started/install) 3.27+
- [Android Studio](https://developer.android.com/studio) ou VS Code com Flutter extension
- Emulador Android ou dispositivo físico

### Instalação

```bash
# 1. Clone o repositório
git clone https://github.com/Alexsantossp71/quitanda.git
cd quitanda

# 2. Instale as dependências
flutter pub get

# 3. Execute (emulador ou dispositivo conectado)
flutter run
```

## 📁 Estrutura do Projeto

```
lib/
├── main.dart              # Ponto de entrada, inicialização GetX
├── src/
│   ├── app/               # Bindings (controllers ↔ pages)
│   ├── config/            # Cores, endpoints, chaves de storage
│   ├── models/            # Modelos (Item, CartItem, Order, AppUser)
│   │   └── *.g.dart       # Código gerado (json_serializable, freezed)
│   ├── pages/             # Telas do app
│   │   ├── auth/          # Login, cadastro, recuperação
│   │   ├── base/          # Navegação principal (abas)
│   │   ├── home/          # Catálogo e categorias
│   │   ├── cart/          # Carrinho de compras
│   │   ├── orders/        # Pedidos
│   │   ├── product/       # Detalhe do produto
│   │   └── profile/       # Perfil do usuário
│   ├── pages_routes/      # Configuração de rotas GetX
│   ├── repositories/      # Camada de dados (API + local)
│   ├── services/          # Serviços (HTTP, storage, auth)
│   └── utils/             # Utilitários (validators, formatters)
├── test/                  # Testes unitários e de widget
└── integration_test/      # Testes de integração
```

## 🧪 Testes

```bash
# Executar todos os testes
flutter test

# Executar com cobertura
flutter test --coverage

# Executar apenas testes unitários
flutter test test/unit/

# Executar apenas testes de widget
flutter test test/widget/
```

## 📐 Princípios de Arquitetura

- **Separation of Concerns**: Pages (UI) ↔ Controllers (lógica) ↔ Models (dados)
- **Dependency Injection**: GetXBindings para desacoplar controllers de implementations
- **Immutability**: Modelos `freezed` com `copyWith` para state updates previsíveis
- **Single Source of Truth**: Controllers GetX como fonte única de estado
- **Repository Pattern**: Repositories abstraem origem dos dados (API vs local)

## 👤 Autor

**Alexandre Ramos**
Estudante de Computação — UNIVESP
Santos, SP — Brasil

[![GitHub](https://img.shields.io/badge/GitHub-Alexsantossp71-181717?logo=github&logoColor=white)](https://github.com/Alexsantossp71)

## 📄 Licença

Este projeto está sob a licença MIT. Veja [LICENSE](LICENSE) para mais detalhes.
