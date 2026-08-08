# Changelog

All notable changes to the Quitanda project will be documented in this file.

## [Unreleased]

## [1.0.0] - 2026-08-08

### Added
- Autenticacao completa (login, cadastro, recuperacao de senha)
- Catalogo de produtos com categorias e busca
- Carrinho de compras com controle de quantidade
- Historico de pedidos com status de acompanhamento
- Perfil do usuario com edicao de dados
- Fluxo de pagamento (dialog)
- Temas customizados e skeleton loading (shimmer)
- Testes unitarios para modelos (CartItem, Order, AppUser, Item)
- CI/CD pipeline com GitHub Actions (test, analyze, build, coverage)
- README profissional com diagrama de arquitetura
- Licenca MIT

### Architecture
- GetX para gerenciamento de estado, rotas e injecao de dependencia
- freezed + json_serializable para modelos imutaveis
- Repository pattern para camada de dados
- Separacao clara: Pages → Controllers → Models → Data Sources

[Unreleased]: https://github.com/Alexsantossp71/quitanda/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/Alexsantossp71/quitanda/releases/tag/v1.0.0
